docker stop nexus-docker
docker rm nexus-docker
docker run --rm -v nexus-volume:/volume --rm --log-driver none loomchild/volume-backup backup - > nexus.tar.bz2
docker resume nexus-docker