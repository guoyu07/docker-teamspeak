# docker-teamspeak

docker teamspeak server container

## build the image:
go to checkout-folder

`cd docker-teamspeak`

`docker build -t teamspeak:3.0.13.3 .`

* move the service file to `/etc/systemd/system`
* `systemctl daemon-reload`
* make dir in `/opt/docker/teamspeak`
* `systemctl start teamspeak`
