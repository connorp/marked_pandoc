#!/usr/bin/env Rscript
# A custom preprocessor for Marked 2 to call rmarkdown::render() on the source document,
# then cancel the processor and have Marked resume processing.


# get the environment set up so we can call render()
setwd(Sys.getenv("MARKED_ORIGIN"))  # Workaround a bug that doesn't remove the .tex file
# Add pandoc and LaTeX to PATH so render() can find them
Sys.setenv(RSTUDIO_PANDOC = "/Applications/RStudio.app/Contents/MacOS/pandoc/")
Sys.setenv(PATH = paste(Sys.getenv("PATH"), "/Library/TeX/texbin/", sep = ":"))

rmarkdown::render(Sys.getenv("MARKED_PATH"), quiet = TRUE)
#   - specify output format explicitly?
#   - specify output location explicitly?
cat("NOCUSTOM")  # to return to the main processor
