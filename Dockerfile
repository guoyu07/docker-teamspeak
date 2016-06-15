FROM ubuntu:16.04 

ENV TS_VERSION="3.0.12.4" TS_SERVER_PLATFORM="linux_amd64" TS_USER="teamspeak" TS_HOME="/teamspeak" TS_INJECTS="/opt/teamspeak_injects" LANG="en_US.UTF-8"

ADD entrypoint.sh /sbin/entrypoint.sh

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get clean && \
    apt-get install -y bzip2 wget sudo libmariadb2 && \
    useradd -m -s /bin/bash "$TS_USER" && \ 
    mkdir "$TS_INJECTS" "$TS_HOME" && \
    wget -q -P "$TS_HOME" http://dl.4players.de/ts/releases/${TS_VERSION}/teamspeak3-server_${TS_SERVER_PLATFORM}-${TS_VERSION}.tar.bz2 && \
    tar -xjf $TS_HOME/teamspeak3-server_${TS_SERVER_PLATFORM}-${TS_VERSION}.tar.bz2 --strip-components=1 -C $TS_HOME && \
    rm -rf $TS_HOME/teamspeak3-server_${TS_SERVER_PLATFORM}-${TS_VERSION}.tar.bz2 && \
    cp $TS_HOME/redist/libmariadb.so.2 $TS_HOME && \
    chown -R "$TS_USER". "$TS_INJECTS" "$TS_HOME" && \
    locale-gen en_US en_US.UTF-8 && \
    update-locale

COPY ["ts3server.ini", "ts3db_mariadb.ini", "$TS_HOME/"]

VOLUME ["$TS_INJECTS", "$TS_HOME/logs", "$TS_HOME/files"]

EXPOSE 9987/udp 10011 30033

ENTRYPOINT ["/sbin/entrypoint.sh"]
