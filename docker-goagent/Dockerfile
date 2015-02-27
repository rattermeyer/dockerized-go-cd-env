FROM gocd/gocd-agent:14.4.0
MAINTAINER Richard Attermeyer "richard.attermeyer@gmail.com"

ENV REFRESHED_AT 2015-02-17

ENV http_proxy http://squid:3128
ENV https_proxy http://squid:3128
ENV no_proxy "localhost,download.oracle.com,edelivery.oracle.com"
RUN echo "Acquire::http::Proxy \"http://apt-cacher:3142\";" > /etc/apt/apt.conf.d/01proxy

# Consul specific settings
ENV SERVICE_NAME go-agent

RUN apt-get -qq update && apt-get upgrade -qqy 

# Disable (only for Demo!!!!) secure host checking
RUN echo StrictHostKeyChecking no >> /etc/ssh/ssh_config
RUN echo UserKnownHostsFile /dev/null >> /etc/ssh/ssh_config

# install software-properties-common (ubuntu >= 12.10) to be able to use add-apt-repository
RUN apt-get -qq -y install software-properties-common
# add PPA for java
RUN add-apt-repository ppa:webupd8team/java
# resynchronize package index files from their sources
RUN apt-get -qq update

# accept Oracle license
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
# install jdk7
RUN apt-get -qq -y install oracle-java7-installer
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle

# Update and download essential packages
RUN apt-get install -y wget unzip dnsutils git

# ssh setup for go user
RUN mkdir -p /var/go/.ssh && chown -R go:go /var/go/.ssh
ADD ci_insecure /var/go/.ssh/id_rsa
RUN chown go:go /var/go/.ssh/id_rsa && chmod 600 /var/go/.ssh/id_rsa
ADD ci_insecure.pub /var/go/.ssh/id_rsa.pub
ADD ssh_config /var/go/.ssh/config

# Donwload and setup maven
RUN wget http://mirror.synyx.de/apache/maven/maven-3/3.2.5/binaries/apache-maven-3.2.5-bin.tar.gz -O /tmp/maven.tar.gz
RUN mkdir /usr/local/maven
RUN tar -C /usr/local/maven -xzvf /tmp/maven.tar.gz
ENV M2_HOME /usr/local/maven/apache-maven-3.2.5
ENV M2 /usr/local/maven/apache-maven-3.2.5/bin
ENV JAVA_HOME /usr/lib/jvm/java-1.7.0-openjdk-amd64
ENV PATH $M2:$JAVA_HOME:$PATH
RUN ln -s /usr/local/maven/apache-maven-3.2.5/bin/mvn /usr/bin/mvn

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# Start Go Agent, create go-agent logfile and tail it
CMD /etc/init.d/go-agent start && > /var/log/go-agent/go-agent.log && tail -F /var/log/go-agent/go-agent.log

CMD ["/sbin/my_init"]
