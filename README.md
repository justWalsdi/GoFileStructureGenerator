# Go file structure generator

## Description

This shell script creates file structre for go project to use in VSCode/VSCodium.
It assumes user stores their Go projects in `Go` folder. 
If argument was provided creates a folder with files inside and creates github repo.
If argument was not provided AND `$PWD` is not equal to `Go` will initialize Go project with a folder's name.

The script assumes that user stores their Go lang projects inside `Go` folder and prevents project initialization inside of it.

## Dependencies

- `zsh` or `bash`. If you're using Bash change the first line to `#!/bin/bash` or to shell of your choice.
- [Github CLI](https://cli.github.com/) is used to manage repos. You need to log in before script can create repos.
    Installation instructions can be found [here](https://github.com/cli/cli#installation).
- [Git](https://git-scm.com).