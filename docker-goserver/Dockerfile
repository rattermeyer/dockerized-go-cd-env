FROM rattermeyer/ubuntu-openjdk:jdk8
MAINTAINER Richard Attermeyer "richard.attermeyer@gmail.com"

# Consul specifig customizations (optional, but make it more readable)
ENV SERVICE_NAME go-server
ENV REFRESHED_AT 2015-07-29
ENV GO_VERSION=15.2.0-2248

#ENV http_proxy http://squid:3128
#ENV https_proxy http://squid:3128
#ENV no_proxy "localhost,download.oracle.com,edelivery.oracle.com"
#RUN echo "Acquire::http::Proxy \"http://apt-cacher:3142\";" > /etc/apt/apt.conf.d/01proxy

# optional to use Oracle JDK
## install software-properties-common (ubuntu >= 12.10) to be able to use add-apt-repository
#RUN apt-get -qq -y install software-properties-common
## add PPA for java
#RUN add-apt-repository ppa:webupd8team/java
## resynchronize package index files from their sources
#RUN apt-get -qq update
#
## accept Oracle license
#RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
## install jdk7
#RUN apt-get -qq -y install oracle-java7-installer
#ENV JAVA_HOME /usr/lib/jvm/java-7-oracle

ADD http://download.go.cd/gocd-deb/go-server-${GO_VERSION}.deb /tmp/go-server.deb
RUN DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get install -y -q unzip curl

COPY go-common-scripts.sh /var/go/
COPY go-server-start.sh /var/go/

RUN ["groupadd", "-r", "go"]
RUN ["useradd", "-r", "-c", "Go User", "-g", "go", "-d", "/var/go", "-m", "-s", "/bin/bash", "go"]
RUN ["mkdir", "-p", "/var/lib/go-server/addons", "/var/log/go-server", "/etc/go", "/go-addons"]
RUN ["touch", "/etc/go/postgresqldb.properties"]
RUN ["chown", "-R", "go:go", "/var/lib/go-server", "/var/log/go-server", "/etc/go", "/go-addons"]
VOLUME ["/var/lib/go-server", "/var/log/go-server", "/etc/go", "/go-addons"]

WORKDIR /tmp
RUN dpkg -i --debug=10 /tmp/go-server.deb
RUN sed -i -e 's/DAEMON=Y/DAEMON=N/' /etc/default/go-server

EXPOSE 8153 8154

# ssh setup for go user for demo
RUN mkdir -p /var/go/.ssh && chown -R go:go /var/go/.ssh
ADD ci_insecure /var/go/.ssh/id_rsa
RUN chown go:go /var/go/.ssh/id_rsa && chmod 600 /var/go/.ssh/id_rsa
ADD ci_insecure.pub /var/go/.ssh/id_rsa.pub
ADD ssh_config /var/go/.ssh/config

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["/var/go/go-server-start.sh"]
