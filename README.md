# docker-teamspeak
docker implementation of TeamSpeak3

This container will only work with an existing database-server (MariaDB) as it does not provide its own.

It took me a while to figure out, why it always crashed after 20 minutes, but I just forgot to copy something from redist folder.

You could use the following command to start the container:
```
docker run \
  -p 9987:9987/udp \
  -p 10011:10011 \
  -p 30033:30033 \
  -v /opt/docker/teamspeak/injects:/opt/teamspeak_injects \
  -v /opt/docker/teamspeak/logs:/teamspeak/logs \
  -v /opt/docker/teamspeak/files:/teamspeak/files \
  --name teamspeak-container \
  docker-teamspeak
```
