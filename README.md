# Generate Documents from Marked via Pandoc

shell script preprocessor for [Marked.app](http://marked2app.com) to export the previewed markdown document to an output file via [pandoc](http://pandoc.org). Defaults to exporting a PDF, other formats can be specified by defining the desired file extension via [MultiMarkdown Metadata](https://marked2app.com/help/Per-Document_Settings.html):

```
Custom Preprocessor: [true, "docx"]
```

If the previewed content is from the clipboard or saved in `~/Library/Caches/Marked 2/Watchers/`, the output file is saved to the Desktop. Otherwise, the output is saved in the same directory as the source file.
