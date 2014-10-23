FROM rattermeyer/ubuntu-jdk:1.0
MAINTAINER Patrick M�ller "patrick-mueller@gmx.net"

#RUN rm -fR /var/lib/apt/lists/*
RUN apt-get update
RUN apt-get upgrade -y --force-yes
RUN apt-get install wget
RUN apt-get install unzip
RUN wget http://download.go.cd/gocd-deb/go-server-14.2.0-377.deb -O /tmp/go-server.deb
RUN dpkg -i /tmp/go-server.deb
# Go Server Port
EXPOSE 8153
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# Start Go Server
CMD ["ls"]