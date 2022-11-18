docker run -d -p 8090:8081 --restart unless-stopped --name nexus -v nexus-data:/nexus-data sonatype/nexus3
docker exec nexus /bin/bash -c 'cat /nexus-data/admin.password'
