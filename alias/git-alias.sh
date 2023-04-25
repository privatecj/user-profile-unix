# Git alias
alias ga="git add ."
alias gs="git status"
alias gc="git commit -m "
alias gca="git commit --amend -m "
alias gt="git add .; git commit -m 'temp';"
alias gtp="git add .; git commit -m 'temp';git push;"
alias gp="git push;"

function gclean(){
    branch_name=$(git branch -l master main | sed 's/^* //');
    git reset --hard HEAD
    git checkout $branch_name
    git fetch --all --prune
    git branch -lvv | cut -c3- | awk '/: gone]/ {print $1}' | xargs git branch -D;
	git checkout $branch_name
	git pull
}

alias gb="git branch -va"
alias gl="git log --oneline --decorate --graph --all -n 20"

alias git-user-office="git config user.name 'Srikrishna Cj'; git config user.email 'ssekhar2@ford.com'; git config user.name; git config user.email;"
alias git-user-cj="git config user.name 'Cj'; git config user.email 'srikrishna.cj@gmail.com'; git config user.name; git config user.email;"
