# manualmerge


This is a handy-dandy tool for rapidly comparing foreign changes in a git environment.

Occasionally while working in git, you will need to merge code that was not written within your git repository.

when this happens, you will need to review all the changes, discarding files where the files don't match because they don't contain changes in your repository, where other files may require manual intervention.

This program is designed to help automate discarding changes. reviewing diffs to a specified list of files, then calling 'checkout' on those files, or adding them to a file called manualmerge_output.txt, indicating that you need to review these files in detail.

Call this program from the root of your git repository.

Provide as an argument to this program, a file path which contains a list of paths local to your git repository

`manualmerge ./filesToReview.txt`

filesToReview.txt shuld be formatted as such:

```
myfile1.js
src/myfile2.js
src/myfile3.txt
src/service/myfile3.doc
```

Where all filepaths are in relation to the root of your repository (similar to a gitignore file)
