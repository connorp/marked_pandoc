#!/usr/bin/env Rscript
# A custom preprocessor for Marked 2 to call rmarkdown::render() on the source document,
# then cancel the processor and have Marked resume processing.

## First get the environment set up so we can call render()
# Work around a bug in render() that doesn't remove .tex file when the working directory
# is not where the file is
setwd(Sys.getenv("MARKED_ORIGIN"))

# Add pandoc and LaTeX to PATH so render() can find them.
# Note these hardcoded paths might need to be changed for different systems
Sys.setenv(RSTUDIO_PANDOC = "/Applications/RStudio.app/Contents/MacOS/quarto/bin")
Sys.setenv(PATH = paste(Sys.getenv("PATH"), "/Library/TeX/texbin/",
						"/opt/homebrew/bin/", sep = ":"))

rmarkdown::render(Sys.getenv("MARKED_PATH"), quiet = TRUE)

cat("NOCUSTOM")  # to return to the main processor

## For reference: the arguments passed to pandoc when used as a custom processor:

# +RTS -K512m -RTS --mathml --from commonmark_x -t html5 --section-divs --standalone --citeproc -M document-css=false --resource-path=.:$MARKED_ORIGIN

# +RTS -K512m -RTS protects against some security vulnerabilities
#
# --section-divs adds <section>s or \section{}s when writing headers
#
# --mathml is used so I can copy-paste the resulting HTML into Canvas/bCourses
#
# -M document-css=false disables the default pandoc CSS so Marked can inject its own
#
# --resource-path=.:$MARKED_ORIGIN looks for files (like images, .bib files, etc) in
# the directory where the source file is, since pandoc is called in a clean shell
# and the working directory is not the directory where the source file is.
#
# The rest are copied from how render() calls pandoc.
