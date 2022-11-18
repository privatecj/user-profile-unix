APP_NAME=$1
CONTAINER_NAME=$APP_NAME-container
VOLUME_NAME=$APP_NAME-volume
echo $CONTAINER_NAME
echo $VOLUME_NAME

docker volume create $VOLUME_NAME
docker run -d -p 8081:8081 --name nexus-docker -v nexus-volume:/sonatype-work sonatype/nexus:oss