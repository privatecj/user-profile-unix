#docker volume create nexus-volume
#docker run -d -p 8081:8081 --name nexus-docker -v nexus-volume:/sonatype-work sonatype/nexus:oss

./app-install.sh "nexus" "8081:8081" "sonatype/nexus:oss"