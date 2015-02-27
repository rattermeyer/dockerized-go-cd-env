FROM gocd/gocd-server:14.4.0
MAINTAINER Richard Attermeyer "richard.attermeyer@gmail.com"

# Consul specifig customizations (optional, but make it more readable)
ENV SERVICE_NAME go-server

ENV REFRESHED_AT 2015-02-17
ENV DEBIAN_FRONTEND noninteractive

ENV http_proxy http://squid:3128
ENV https_proxy http://squid:3128
ENV no_proxy "localhost,download.oracle.com,edelivery.oracle.com"
RUN echo "Acquire::http::Proxy \"http://apt-cacher:3142\";" > /etc/apt/apt.conf.d/01proxy

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

EXPOSE 8153 8154

# ssh setup for go user
RUN mkdir -p /var/go/.ssh && chown -R go:go /var/go/.ssh
ADD ci_insecure /var/go/.ssh/id_rsa
RUN chown go:go /var/go/.ssh/id_rsa && chmod 600 /var/go/.ssh/id_rsa
ADD ci_insecure.pub /var/go/.ssh/id_rsa.pub
ADD ssh_config /var/go/.ssh/config

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["/sbin/my_init"]
