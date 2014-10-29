FROM rattermeyer/ubuntu-jdk:1.0
MAINTAINER Patrick Müller "patrick-mueller@gmx.net"

# Vagrant
ADD ./prepare-vagrant-user.sh /tmp/
RUN chmod u+x /tmp/prepare-vagrant-user.sh
RUN /tmp/prepare-vagrant-user.sh

# Disable (only for Demo!!!!) secure host checking
RUN echo StrictHostKeyChecking no >> /etc/ssh/ssh_config
RUN echo UserKnownHostsFile /dev/null >> /etc/ssh/ssh_config

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
# Start Go Server, create go-server logfile and tail it
CMD /usr/share/go-server/server.sh && > /var/log/go-server/go-server.log && tail -F /var/log/go-server/go-server.log
