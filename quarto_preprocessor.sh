#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# a custom preprocessor for Marked 2 to use Quarto's render function on the source
# document, rendering to the specified outputs, using a default YAML file

export PATH="$PATH:/Applications/RStudio.app/Contents/MacOS/pandoc:/opt/R/arm64:/opt/homebrew/opt/llvm/bin:/Library/TeX/texbin/:/opt/homebrew/bin/"

/usr/local/bin/quarto render $MARKED_PATH --metadata-file=/Users/connor/Development/marked_pandoc/quarto_defaults.yml

echo "NOCUSTOM"
