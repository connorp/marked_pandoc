#!/bin/bash
set -euo pipefail
IFS=$'\n\t'
#
# Recall the two latter commands exit if any command returns nonzero,
# if an undefined variable is called, or if a command mid-pipeline fails,
# and iterates over elements separated by just newlines and tabs, not spaces.
#
# A custom preprocessor for Marked 2 that will export a file to docx or LaTeX pdf
# after Marked does initial inclusion and processing, then cancel the processor and have
# Marked resume processing.

function main()
{
	# MARKED_PATH contains the full path to the document opened in Marked
	# MARKED_ORIGIN contains the full path to the DIRECTORY where the document is
	# MARKED_EXT is the file extension
	# HOME is the current user's home directory. ~ won't work in Marked's shell.
	local filename=$(basename "$MARKED_PATH")
	local filebasename="${filename%.*}"
	# filebasename is the base name of the file only, with the extension removed

	# If the file is in the Caches directory or is from the clipboard, put the result
	# on the desktop. Otherwise, put it where the source file is.
	if [ "$MARKED_ORIGIN" == "$HOME/Library/Caches/Marked 2/Watchers/" ] || [ "$filebasename" == "Clipboard Preview" ]
	then
	    local outpath="$HOME/Desktop/"
	else
	    local outpath="$MARKED_ORIGIN"
	fi

	local desiredextension="${1:-pdf}"  # Change this to change the output format
	local outputfile="$outpath$filebasename.$desiredextension"

	if [ "$desiredextension" == "pdf" ]
	then
	    local metadata="--metadata-file=$HOME/Development/marked_pandoc/template.yml"
	else
	    local metadata=""
	fi

    shopt -s nocasematch
	if [[ "${2:-false}" == "true" || "${2:-false}" == "yes" ]]
	then
	    local adddate="--lua-filter=$HOME/Development/marked_pandoc/add_date.lua"
	else
	    local adddate=""
	fi
	shopt -u nocasematch

	$HOME/bin/pandoc -f markdown "$MARKED_PATH" -o "$outputfile" --pdf-engine=/Library/TeX/texbin/xelatex $adddate $metadata

	# Returning "NOCUSTOM" tells Marked to skip the processor and resume rendering
	echo "NOCUSTOM"
	return 0
}

cat | main $@
