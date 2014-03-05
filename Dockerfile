FROM phusion/baseimage

RUN apt-get update
RUN apt-get install -y mongodb mongodb-server
RUN mkdir -p /data/db/

WORKDIR /root
RUN git clone https://github.com/square/cube.git

WORKDIR /root/cube
RUN npm install
RUN mkdir -p /usr/local/var/log/cube

ADD start-cube /bin/start-cube
RUN chmod +x /bin/start-cube

ENTRYPOINT "/sbin/my_init -- /bin/start-cube"
