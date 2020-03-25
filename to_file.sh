#!/bin/bash

# A custom preprocessor for Marked 2 that will export a file to docx or LaTeX pdf
# after Marked does initial inclusion and processing, then cancel the processor and have
# Marked resume processing.

function main()
{
	# MARKED_PATH contains the full path to the document opened in Marked
	# MARKED_ORIGIN contains the full path to the DIRECTORY where the document is
	# MARKED_EXT is the file extension
	local filename=$(basename "$MARKED_PATH")
	local filebasename="${filename%.*}"
	# filebasename is the base name of the file only, with the extension removed

	# If the file is in the Caches directory or is from the clipboard, put the result
	# on the desktop. Otherwise, put it where the source file is.
	if [ "$MARKED_ORIGIN" == "/Users/connor/Library/Caches/Marked 2/Watchers/" ]
	then
	    local outpath="/Users/connor/Desktop/"
	elif [ "$filebasename" == "Clipboard Preview" ]
	then
	    local outpath="/Users/connor/Desktop/"
	else
	    local outpath="$MARKED_ORIGIN"
	fi


	local desiredextension="${1:-pdf}"  # Change this to change the output format
	local outputfile="$outpath$filebasename.$desiredextension"

	/usr/local/bin/pandoc -f markdown "$MARKED_PATH" -o "$outputfile" --pdf-engine=/Library/TeX/texbin/xelatex

	# Returning "NOCUSTOM" tells Marked to skip the processor and resume rendering
	echo "NOCUSTOM"
	return 0
}

cat | main $@
