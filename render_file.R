#!/usr/bin/env Rscript
# A custom preprocessor for Marked 2 to call rmarkdown::render() on the source document,
# then cancel the processor and have Marked resume processing.

Sys.setenv(RSTUDIO_PANDOC = "/Applications/RStudio.app/Contents/MacOS/pandoc/")

rmarkdown::render(Sys.getenv("MARKED_PATH"), quiet = TRUE)
#   - specify output format explicitly?
#   - specify output location explicitly?
cat("NOCUSTOM")  # to return to the main processor
