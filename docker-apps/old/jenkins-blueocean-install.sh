docker volume create jenkins-blueocean
docker run -d -p 8080:8080 -v jenkins-blueocean:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock jenkinsci/blueocean

docker volume create jenkins
docker run --privileged -p 8080:8080 -v jenkins:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock jenkins/jenkins


docker volume create gocd
docker run -p8080:8153 -v gocd:/godata -v /var/run/docker.sock:/var/run/docker.sock gocd/gocd-server:v21.1.0
