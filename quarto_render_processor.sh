#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# a custom processor for Marked 2 to use Quarto's render function on the source
# document, rendering to HTML, using a default YAML file, and outputting to STDOUT

export PATH="$PATH:/Applications/RStudio.app/Contents/MacOS/pandoc:/opt/R/arm64:/opt/homebrew/opt/llvm/bin:/Library/TeX/texbin/:/opt/homebrew/bin/"

# This works, but it still uses Quarto's CSS, rather than forgoing CSS
/usr/local/bin/quarto render $MARKED_PATH --to html --execute-params ~/Development/marked_pandoc/quarto_defaults.yml --output -
