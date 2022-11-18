docker pause nexus-docker
cat nexus.tar.bz2 | docker run -i -v nexus-volume:/volume --rm loomchild/volume-backup restore -
docker resume nexus-docker