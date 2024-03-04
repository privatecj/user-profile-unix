alias docker="docker"
alias dc="docker "

alias dcls='docker ps --format "table {{.ID}}\t\t{{.Names}}\t\t{{.Image}}\t\t{{.Status}}"'
alias dcst="docker start "
alias dcsp="docker stop "
alias dcrm="docker rm -f "

function dcc(){
  docker system prune -f
}

function dcf(){
    docker kill $(docker ps -q)
    docker rm $(docker ps -a -q)
    docker rmi $(docker images -q)
    docker volume rm $(docker volume ls -q)
    docker network rm $(docker network ls -q)
}