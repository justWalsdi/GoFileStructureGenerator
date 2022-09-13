#!/bin/zsh

vscode="{\n    \"version\": \"0.2.0\",\n    \"configurations\": [\n        {\n            \"name\": \"Launch Package\",\n            \"type\": \"go\",\n            \"request\": \"launch\",\n            \"mode\": \"auto\",\n            \"program\": \"./cmd/main.go\",\n            \"output\": \"./build/debug.bin\"\n        }\n    ]\n}"
makefile=".DEFAULT_GOAL := build\nfmt:\n\tgo fmt ./...\n.PHONY:fmt\nlint: fmt\n\tgolint ./...\n.PHONY:lint\nvet: fmt\n\tgo vet ./...\n.PHONY:vet\n\tMakefiles |\nlint-ci:\n\tgolangci-lint run\n.PHONY:lint-ci\nbuild: vet\n\tmkdir build\n\tgo build -o ./build/ ./cmd/main.go\n .PHONY:build\nclean:\n\trm -r ./build\n.PHONY:clean\nrun:\n\tgo run ./cmd/main.go\n.PHONY:run"
main="package main\n\nfunc main() {\n\t\n}"

function createFiles {
    _cwd=$(pwd)
    mkdir $_cwd/cmd $_cwd/pkg $_cwd/.vscode
    echo ".vscode/" > $_cwd/.gitignore
    echo $main > $_cwd/cmd/main.go
    echo $makefile > $_cwd/Makefile
    echo $vscode > $_cwd/.vscode/launch.json
}

if [ $# -gt 0 ]; then
    mkdir $1 && cd $1
    createFiles
    echo "# ${PWD##*/}" > README.md
    go mod init github.com/justWalsdi/$1
    git init
    gh repo create $1 --public --source . --remote=upstream
else
    if [ "${PWD##*/}" != "Go" ]; then
        createFiles
        go mod init ${PWD##*/}
        echo "# ${PWD##*/}" > README.md
    else 
        echo "You are in the wrong folder buddy. Provide the name of the project."
    fi
fi
