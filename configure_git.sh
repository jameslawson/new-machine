#!/bin/bash

echo ">>>> Configuring git"

# git config --system http.proxy $HTTP_PROXY
# git config --system https.proxy $HTTPS_PROXY
git config --global user.name "James Lawson"
git config --global user.email "jameslawson@users.noreply.github.com"

# -- use vimdiff
git config --global diff.tool vimdiff
git config --global difftool.prompt false

git config --global alias.co checkout
git config --global alias.st status
git config --global alias.ci commit -v
# git config --global alias.lg log --graph --oneline --decorate --all
git config --global alias.d difftool

git config --global url.ssh://git@github.com/.insteadOf https://github.com/
git config --global core.excludesfile ~/.gitignore_global
git config --global core.hooksPath ~/.git-templates/hooks

echo ">>> Success: configured git"
echo ">>> You can view all git config using: git config --list --show-origin"
echo ">>> You can view global config using: git config --list --global"
echo ">>> You can view system config using: git config --list --system"
echo ">>> For more info, see git-config documentation: https://git-scm.com/docs/git-config"


