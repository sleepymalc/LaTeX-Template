# Beamer

Two styles share this folder. Each variant is self-contained: a `header.tex`
with the full preamble and a `main.tex` demo that shows every environment.

```
Beamer/
├── header.tex      # back-compat shim -> Classical/header.tex
├── Figures/logo/   # logos shared by both variants (absolute path, see below)
├── Classical/      # Madrid theme, numbered blocks, logo on every frame
└── Modern/         # Moloch theme, progress bar, flat filled blocks
```

## Usage

Start a talk with `main.tex` and `reference.bib` from one variant, or pull the
header in by absolute path so every talk picks up template updates:

```latex
\PassOptionsToPackage{prologue,dvipsnames}{xcolor}
\PassOptionsToPackage{colorlinks=true,linkcolor=.,urlcolor=mLightBrown,citecolor=mLightBrown,hyperfootnotes=true}{hyperref}
\documentclass[aspectratio=169,10pt]{beamer}
\input{~/Developer/LaTeX-Template/Beamer/Modern/header.tex}
```

For the classical style use `Classical/header.tex` and the hyperref colors
from `Classical/main.tex`. Build with `latexmk -pdf` (pdflatex + biber).

## Notes

- `Figures/logo/` and `header.tex` stay at the top level because existing talks
  reference them by absolute path. Once no talk uses the shim, delete it.
- Both headers define the same math macros and environments (`goal`, `prev`,
  `observe`, `assumption`, `remark`, `intuition`, `\incfig`, ...), so content
  moves between styles unchanged. Modern additionally provides
  `\styleblock{color}` for one-off block colors and `[standout]` frames.
