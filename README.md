# LaTeX Report Template

Docker-based thesis template for RAI capstone reports. It builds with `latexmk` + `XeLaTeX`, uses TH Sarabun for Thai/English documents, and handles references with `biblatex` + Biber.

## Run

From `report-template/`:

```bash
./build.sh build
```

Useful commands:

```bash
./build.sh build         # compile once
./build.sh watch         # rebuild on file changes
./build.sh clean         # remove build output and cache
./build.sh shell         # open a shell in the LaTeX container
./build.sh rebuild-image # rebuild the Docker image
```

`make build`, `make watch`, `make clean`, `make shell`, and `make image` are available as shortcuts.

The generated PDF is written to `build/thesis.pdf`. Auxiliary files go to `.cache/latexmk/`.

## Technology

- Docker provides the LaTeX toolchain, so no local TeX install is required.
- `latexmk` drives the build and reruns compilation as needed.
- `XeLaTeX` is the document engine.
- `polyglossia` is configured for English and Thai text.
- TH Sarabun font files are bundled in `fonts/`.
- `biblatex` with Biber is used for bibliography generation.

## Main Files

- `thesis.tex`: document entry point and thesis metadata
- `env.tex`: fonts, spacing, page layout, bibliography, and package setup
- `chapters/`: abstract, front matter, and chapter content
- `references.bib`: bibliography entries
- `images/`: figures used in the report
