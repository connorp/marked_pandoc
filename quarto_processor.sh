#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# a custom processor for Marked 2 to use Quarto's render function on the source
# document, rendering to HTML, using a default YAML file, and outputting to STDOUT

export PATH="$PATH:/Applications/RStudio.app/Contents/MacOS/pandoc:/opt/R/arm64:/opt/homebrew/opt/llvm/bin:/Library/TeX/texbin/:/opt/homebrew/bin/"

/usr/local/bin/quarto render $MARKED_PATH --to html --output -

# --metadata-file=/Users/connor/Development/marked_pandoc/processor_defaults.yml
