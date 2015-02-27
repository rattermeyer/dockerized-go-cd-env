FROM rattermeyer/ubuntu-jdk:1.0
MAINTAINER Richard Attermeyer "richard.attermeyer@gmail.com"

ENV REFRESHED_AT 2015-02-17

ENV http_proxy http://squid:3128
ENV https_proxy http://squid:3128
RUN echo "Acquire::http::Proxy \"http://apt-cacher:3142\";" > /etc/apt/apt.conf.d/01proxy

ENV SONAR_HOME /opt/sonarqube-5.0
 
RUN apt-get update
RUN apt-get install -y unzip wget

RUN wget -P /opt http://dist.sonar.codehaus.org/sonarqube-5.0.zip

RUN unzip /opt/sonarqube-5.0.zip -d /opt

COPY conf/wrapper.conf /opt/sonarqube-5.0/conf/wrapper.conf
COPY conf/sonar.properties /opt/sonarqube-5.0/conf/sonar.properties

#ADD plugins.sh /tmp/plugins.sh
#WORKDIR /opt/sonarqube-5.0/extensions/downloads
#RUN chmod u+x /tmp/plugins.sh
#RUN /tmp/plugins.sh

EXPOSE 9000

ENV SONAR_USER sonar
ENV SONAR_PASSWORD sonar
ENV SONAR_JDBC_URL jdbc:h2:tcp://localhost:9092/sonar
ENV SONAR_LOG_LEVEL DEBUG

ENTRYPOINT ["/opt/sonarqube-5.0/bin/linux-x86-64/sonar.sh"]
CMD ["console"]
