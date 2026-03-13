# LaTeX Report Template

This report template is built around a Docker-first `LuaLaTeX` workflow. The toolchain lives in a container, auxiliary files stay in `.cache/latexmk/`, and the final PDF is written to `build/thesis.pdf`.

## Why This Setup

- No local TeX installation is required on macOS or Linux
- The build environment is reproducible across machines
- Generated files are separated from source files
- `latexmk` handles bibliography runs and incremental rebuilds automatically
- The image now uses Alpine Linux to keep the base layer smaller and simpler

## Project Layout

```text
report/
├── .cache/           # LaTeX auxiliary files created during builds
├── build/            # Final PDF output
├── chapters/         # Front matter and chapter files
├── fonts/            # TH Sarabun font files
├── images/           # Figures used in the report
├── .dockerignore     # Smaller Docker build context
├── .latexmkrc        # Shared latexmk configuration
├── Dockerfile        # Reproducible LaTeX toolchain
├── Makefile          # Shortcuts for common commands
├── build.sh          # Docker-based task runner
├── thesis.tex        # Main document and thesis metadata
├── env.tex           # Packages and formatting
└── references.bib    # Bibliography entries
```

## Requirements

- Docker

That is the only required dependency for building the report.

## Quick Start

From the `report/` directory:

```bash
./build.sh build
```

Or with `make`:

```bash
make build
```

After a successful build, the PDF is available at `build/thesis.pdf`. On macOS, the script also opens it automatically.

## Common Commands

Build the report once:

```bash
./build.sh build
```

Watch files and rebuild automatically:

```bash
./build.sh watch
```

Remove generated output and cache:

```bash
./build.sh clean
```

Open a shell inside the LaTeX container:

```bash
./build.sh shell
```

Rebuild the Docker image only:

```bash
./build.sh rebuild-image
```

If you prefer `make`, the same commands are available as `make build`, `make watch`, `make clean`, `make shell`, and `make image`.

## Build System Notes

- `Dockerfile` uses Alpine Linux plus the TeX Live packages required by this template
- `.latexmkrc` keeps the output and cache policy in one place
- `build.sh` is the main entry point and uses Docker for all build tasks
- `Makefile` is a convenience layer on top of `build.sh`
- `.dockerignore` keeps the Docker build context small
- Alpine reduces OS overhead, but TeX Live packages still make the image fairly large overall

## What To Edit

- Update thesis metadata at the top of `thesis.tex`
- Replace the placeholder text in `chapters/abstract.tex`
- Replace the placeholder text in `chapters/acknowledgement.tex`
- Add or remove the abbreviations section in `chapters/frontmatter.tex`
- Fill in the chapter files under `chapters/`
- Add bibliography entries in `references.bib`

## Working With Assets

- Put figures in `images/`
- Keep custom fonts in `fonts/`
- Add bibliography entries to `references.bib`

## Output Policy

- Do not commit `.cache/` or `build/`
- The generated PDF should always be read from `build/thesis.pdf`
- The source tree should stay focused on editable report content
