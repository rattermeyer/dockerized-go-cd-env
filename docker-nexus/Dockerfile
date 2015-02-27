FROM rattermeyer/ubuntu-jdk:1.0
MAINTAINER Richard Attermeyer "richard.attermeyer@gmail.com"
ENV REFRESHED_AT 2015-02-22

ENV http_proxy http://squid:3128
ENV https_proxy http://squid:3128
RUN echo "Acquire::http::Proxy \"http://apt-cacher:3142\";" > /etc/apt/apt.conf.d/01proxy

RUN apt-get -qq update 

# download nexus
RUN curl https://sonatype-download.global.ssl.fastly.net/nexus/oss/nexus-2.11.1-01-bundle.tar.gz | tar -C /srv -xz 
VOLUME  ["/opt/sonatype-work", "/opt/nexus/conf"]
# Prepare Nexus (esp. add candidates repository)
ADD sonatype-work.tar.gz /srv/
EXPOSE 8081 
ENTRYPOINT ["/srv/nexus-2.11.1-01/bin/jsw/linux-x86-64/wrapper","/srv/nexus-2.11.1-01/bin/jsw/conf/wrapper.conf","wrapper.syslog.ident=nexus"]
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

