#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUILD_DIR="$SCRIPT_DIR/build"
AUX_DIR="$SCRIPT_DIR/.cache/latexmk"
IMAGE_NAME="${IMAGE_NAME:-capstone-report-latex}"
IMAGE_TAG="${IMAGE_TAG:-latest}"
IMAGE_REF="${IMAGE_NAME}:${IMAGE_TAG}"
COMMAND="${1:-build}"

cd "$SCRIPT_DIR"
mkdir -p "$BUILD_DIR" "$AUX_DIR"

build_image() {
  docker build -t "$IMAGE_REF" .
}

ensure_image() {
  if ! docker image inspect "$IMAGE_REF" >/dev/null 2>&1; then
    build_image
  fi
}

run_in_docker() {
  docker run --rm \
    --init \
    --user "$(id -u):$(id -g)" \
    --env HOME=/tmp \
    --volume "$SCRIPT_DIR:/work" \
    --workdir /work \
    "$IMAGE_REF" \
    "$@"
}

open_pdf_if_available() {
  if command -v open >/dev/null 2>&1 && [ -f "$BUILD_DIR/thesis.pdf" ]; then
    open "$BUILD_DIR/thesis.pdf"
  fi
}

if ! command -v docker >/dev/null 2>&1; then
  echo "Docker is required for this project."
  exit 1
fi

case "$COMMAND" in
  build)
    ensure_image
    run_in_docker latexmk thesis.tex
    open_pdf_if_available
    ;;
  watch)
    ensure_image
    run_in_docker latexmk -pvc -view=none thesis.tex
    ;;
  clean)
    rm -rf "$BUILD_DIR" "$SCRIPT_DIR/.cache"
    ;;
  shell)
    ensure_image
    docker run --rm -it \
      --init \
      --user "$(id -u):$(id -g)" \
      --env HOME=/tmp \
      --volume "$SCRIPT_DIR:/work" \
      --workdir /work \
      "$IMAGE_REF" \
      bash
    ;;
  rebuild-image)
    build_image
    ;;
  *)
    cat <<'EOF'
Usage: ./build.sh [build|watch|clean|shell|rebuild-image]

Commands:
  build          Build build/thesis.pdf with Docker
  watch          Rebuild on file changes with latexmk -pvc
  clean          Remove build output and LaTeX cache
  shell          Open an interactive shell inside the LaTeX container
  rebuild-image  Rebuild the Docker image without compiling
EOF
    exit 1
    ;;
esac
