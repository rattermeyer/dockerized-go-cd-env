FROM rattermeyer/ubuntu-jdk:1.0
MAINTAINER Patrick Müller "patrick-mueller@gmx.net"

# Vagrant
ADD ./prepare-vagrant-user.sh /tmp/
RUN chmod u+x /tmp/prepare-vagrant-user.sh
RUN /tmp/prepare-vagrant-user.sh

# Disable (only for Demo!!!!) secure host checking
RUN echo StrictHostKeyChecking no >> /etc/ssh/ssh_config
RUN echo UserKnownHostsFile /dev/null >> /etc/ssh/ssh_config

# Update and download essential packages
RUN apt-get update
RUN apt-get upgrade -y --force-yes
RUN apt-get install -y wget unzip dnsutils

# Download and setup Go Agent
RUN wget http://download.go.cd/gocd-deb/go-agent-14.2.0-377.deb -O /tmp/go-agent.deb
RUN dpkg -i /tmp/go-agent.deb
RUN sed -i 's/GO_SERVER=127.0.0.1/GO_SERVER=`dig +short godockerci_goserver.dev.docker`/g' /etc/default/go-agent
RUN sed -i 's/DAEMON=Y/DAEMON=N/g' /etc/default/go-agent

# Donwload and setup maven
RUN wget http://mirror.synyx.de/apache/maven/maven-3/3.2.3/binaries/apache-maven-3.2.3-bin.tar.gz -O /tmp/maven.tar.gz
RUN mkdir /usr/local/maven
RUN cd /usr/local/maven
RUN tar -xzf /tmp/maven.tar.gz
RUN export PATH=$M2:$JAVA_HOME:$PATH

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# Start Go Agent, create go-agent logfile and tail it
CMD /etc/init.d/go-agent start && > /var/log/go-agent/go-agent.log && tail -F /var/log/go-agent/go-agent.log
