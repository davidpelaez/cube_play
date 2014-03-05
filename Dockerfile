FROM phusion/baseimage

# Add 10gen official apt source to the sources list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/10gen.list

# Hack for initctl not being available in Ubuntu
#RUN dpkg-divert --local --rename --add /sbin/initctl
#RUN ln -s /bin/true /sbin/initctl

RUN apt-get update
RUN apt-get install -y mongodb-10gen git

RUN apt-get update
RUN apt-get install -y python-software-properties python g++ make
RUN add-apt-repository ppa:chris-lea/node.js

#RUN echo 'deb http://ppa.launchpad.net/chris-lea/node.js/ubuntu precise main' | tee /etc/apt/sources.list.d/christ-lea.list
#RUN echo 'deb-src http://ppa.launchpad.net/chris-lea/node.js/ubuntu precise main' | tee /etc/apt/sources.list.d/christ-lea.list

RUN apt-get update
RUN apt-get install -y nodejs

RUN mkdir -p /data/db/

WORKDIR /root
RUN git clone https://github.com/square/cube.git

WORKDIR /root/cube
RUN npm install
RUN mkdir -p /usr/local/var/log/cube

ADD start-cube /bin/start-cube
RUN chmod +x /bin/start-cube

#ENTRYPOINT "/sbin/my_init -- /bin/start-cube"
