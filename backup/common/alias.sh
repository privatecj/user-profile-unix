#!/bin/bash

# SSK KEY GEENRATION
# https://www.sanderverbruggen.com/spring-cloud-config-with-public-private-key-git-access-solving-the-auth-fail-error/
# https://github.com/spring-cloud/spring-cloud-config/issues/1392
echo "Loading alias.sh"

alias generate-key="ssh-keygen -m PEM -t rsa -b 4096"
alias ssh="ssh -o GlobalKnownHostsFile=/dev/null -o UserKnownHostsFile=/dev/null"

# Git alias
alias ga="git add ."
alias gs="git status"
alias gc="git commit -m "
alias gc!="git commit --amend -m "
alias gt="git add .; git commit -m 'temp';"
alias gtp="git add .; git commit -m 'temp'; git push;"

function gclean(){
    git reset --hard HEAD
    git checkout master
    git fetch --all --prune
    git branch -lvv | cut -c3- | awk '/: gone]/ {print $1}' | xargs git branch -D;
	git checkout master
	git pull
}

alias gb="git branch -va"
alias gbc="git checkout "
alias gbn="git checkout -b "
alias gbm="git checkout master"
alias gl="git log --oneline --decorate --graph --all -n 20"

alias goffice="git config user.name 'Srikrishna Cj'; git config user.email 'ssekhar2@ford.com'; git config user.name; git config user.email;"
alias gpersonal="git config user.name 'Cj'; git config user.email 'srikrishna.cj@gmail.com'; git config user.name; git config user.email;"

alias op="cd $MY_DRIVE/office_projects"
alias pp="cd $MY_DRIVE/personal_projects"