#!/usr/bin/env Rscript
# A custom preprocessor for Marked 2 to call rmarkdown::render() on the source document,
# then cancel the processor and have Marked resume processing.

## First get the environment set up so we can call render()
# Work around a bug in render() that doesn't remove .tex file when the working directory
# is not where the file is
setwd(Sys.getenv("MARKED_ORIGIN"))

# Add pandoc and LaTeX to PATH so render() can find them.
# Note these hardcoded paths might need to be changed for different systems
Sys.setenv(RSTUDIO_PANDOC = "/Applications/RStudio.app/Contents/MacOS/pandoc/")
Sys.setenv(PATH = paste(Sys.getenv("PATH"), "/Library/TeX/texbin/", sep = ":"))

rmarkdown::render(Sys.getenv("MARKED_PATH"), quiet = TRUE)

cat("NOCUSTOM")  # to return to the main processor
