# LaTeX Report Template

This thesis template uses a Docker-first `XeLaTeX` workflow with `latexmk`. The build is configured for English content, Thai content, and TH Sarabun fonts out of the box, so bilingual front matter such as `ABSTRACT IN THAI` can be typeset cleanly.

The toolchain lives in a container, auxiliary files stay in `.cache/latexmk/`, and the final PDF is written to `build/thesis.pdf`.

## Why This Setup

- No local TeX installation is required on macOS or Linux
- The build environment is reproducible across machines
- Generated files are separated from source files
- `latexmk` handles repeated compilation and bibliography runs automatically
- `XeLaTeX` is used for more reliable Thai text rendering and line breaking
- `polyglossia` is already configured for English and Thai

## Project Layout

```text
report-template/
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

That is the only required dependency for building the template.

## Quick Start

From the `report-template/` directory:

```bash
./build.sh build
```

Or with `make`:

```bash
make build
```

After a successful build, the PDF is available at `build/thesis.pdf`. On macOS, the script also opens it automatically.

## Common Commands

Build the template once:

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

## Thai Support

This template is preconfigured for Thai text:

- `XeLaTeX` is the active engine
- `polyglossia` is enabled in `env.tex`
- English is the default language and Thai is registered as an additional language
- TH Sarabun is used as both the main font and Thai font family
- XeTeX Thai line breaking is enabled for better paragraph layout

If you add Thai content, you can write it directly in the `.tex` files and wrap Thai sections with:

```tex
\begin{thai}
...
\end{thai}
```

## Build System Notes

- `Dockerfile` installs TeX Live plus `texlive-xetex`
- `.latexmkrc` runs `xelatex`
- `build.sh` is the main entry point and uses Docker for all build tasks
- `Makefile` is a convenience layer on top of `build.sh`
- `env.tex` contains the font, language, spacing, and layout configuration

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
- The source tree should stay focused on editable thesis content
