FROM rattermeyer/ubuntu-openjdk:jdk8
MAINTAINER Richard Attermeyer "richard.attermeyer@gmail.com"

ENV REFRESHED_AT 2015-07-29

#ENV http_proxy http://squid:3128
#ENV https_proxy http://squid:3128
#RUN echo "Acquire::http::Proxy \"http://apt-cacher:3142\";" > /etc/apt/apt.conf.d/01proxy

ENV SONAR_VERSION 5.1.2
ENV SONAR_HOME /opt/sonarqube-$(SONAR_VESION)
 
RUN apt-get update && apt-get install -y unzip wget

RUN wget -P /opt http://dist.sonar.codehaus.org/sonarqube-${SONAR_VERSION}.zip

RUN unzip /opt/sonarqube-${SONAR_VERSION}.zip -d /opt

COPY conf/wrapper.conf /opt/sonarqube-${SONAR_VERSION}/conf/wrapper.conf
COPY conf/sonar.properties /opt/sonarqube-${SONAR_VERSION}/conf/sonar.properties

#ADD plugins.sh /tmp/plugins.sh
#WORKDIR /opt/sonarqube-5.0/extensions/downloads
#RUN chmod u+x /tmp/plugins.sh
#RUN /tmp/plugins.sh

EXPOSE 9000

ENV SONAR_USER sonar
ENV SONAR_PASSWORD sonar
ENV SONAR_JDBC_URL jdbc:h2:tcp://localhost:9092/sonar
ENV SONAR_LOG_LEVEL DEBUG

ENTRYPOINT /opt/sonarqube-${SONAR_VERSION}/bin/linux-x86-64/sonar.sh
CMD ["console"]
