mkdir -p /var/cj/traccar/logs
mkdir -p /var/cj/traccar/config


docker run \
--rm \
--entrypoint cat \
traccar/traccar:latest \
/opt/traccar/conf/traccar.xml > /var/cj/traccar/config/traccar.xml

docker run \
--rm \
--name traccar \
--hostname traccar \
-p 8082:8082 \
-p 5000-5150:5000-5150 \
-p 5000-5150:5000-5150/udp \
-v /var/cj/traccar/logs:/opt/traccar/logs:rw \
-v /var/cj/traccar/config/traccar.xml:/opt/traccar/conf/traccar.xml:ro \
traccar/traccar:latest

docker run \
-d \
--hostname traccar \
-p 8082:8082 \
-p 5000-5150:5000-5150 \
-p 5000-5150:5000-5150/udp \
-v /var/cj/traccar/logs:/opt/traccar/logs:rw \
-v /var/cj/traccar/config/traccar.xml:/opt/traccar/conf/traccar.xml:ro \
traccar/traccar:latest