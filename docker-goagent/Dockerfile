FROM rattermeyer/ubuntu-openjdk:jdk8
MAINTAINER Richard Attermeyer "richard.attermeyer@gmail.com"

ENV REFRESHED_AT 2015-08-30

#ENV http_proxy http://squid:3128
#ENV https_proxy http://squid:3128
#ENV no_proxy "localhost,download.oracle.com,edelivery.oracle.com"
#RUN echo "Acquire::http::Proxy \"http://apt-cacher:3142\";" > /etc/apt/apt.conf.d/01proxy

ENV MAVEN_VERSION 3.2.5

# Consul specific settings
ENV SERVICE_NAME go-agent

RUN apt-get update && apt-get -qq -y install software-properties-common wget unzip dnsutils git openssh-server

# Disable (only for Demo!!!!) secure host checking
RUN echo StrictHostKeyChecking no >> /etc/ssh/ssh_config
RUN echo UserKnownHostsFile /dev/null >> /etc/ssh/ssh_config

ADD http://download.go.cd/gocd-deb/go-agent-15.1.0-1863.deb /tmp/go-agent.deb

WORKDIR /tmp
RUN dpkg -i /tmp/go-agent.deb
RUN sed -i 's/DAEMON=Y/DAEMON=N/' /etc/default/go-agent
COPY go-agent-start.sh /var/go/

# ssh setup for go user
RUN mkdir -p /var/go/.ssh && chown -R go:go /var/go/.ssh
ADD ci_insecure /var/go/.ssh/id_rsa
RUN chown go:go /var/go/.ssh/id_rsa && chmod 600 /var/go/.ssh/id_rsa
ADD ci_insecure.pub /var/go/.ssh/id_rsa.pub
ADD ssh_config /var/go/.ssh/config

# Donwload and setup maven
RUN wget http://mirror.synyx.de/apache/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz -O /tmp/maven.tar.gz
RUN mkdir /usr/local/maven
RUN tar -C /usr/local/maven -xzvf /tmp/maven.tar.gz
ENV M2_HOME /usr/local/maven/apache-maven-${MAVEN_VERSION}
ENV M2 /usr/local/maven/apache-maven-${MAVEN_VERSION}/bin
ENV JAVA_HOME /usr/lib/jvm/java-1.7.0-openjdk-amd64
ENV PATH $M2:$JAVA_HOME:$PATH
RUN ln -s /usr/local/maven/apache-maven-${MAVEN_VERSION}/bin/mvn /usr/bin/mvn

# ADD Settings to go home
RUN mkdir -p /var/go/.m2
ADD settings.xml /var/go/.m2/

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# Start Go Agent, create go-agent logfile and tail it
CMD /etc/init.d/go-agent start && > /var/log/go-agent/go-agent.log && tail -F /var/log/go-agent/go-agent.log

CMD ["/var/go/go-agent-start.sh"]
