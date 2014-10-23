FROM rattermeyer/ubuntu-jdk:1.0
maintainer richard.attermeyer@gmail.com

ENV SONAR_HOME /opt/sonarqube-4.4
 
RUN apt-get update
RUN apt-get install -y unzip wget

RUN wget -P /opt http://dist.sonar.codehaus.org/sonarqube-4.4.zip

RUN unzip /opt/sonarqube-4.4.zip -d /opt

COPY conf/wrapper.conf /opt/sonarqube-4.4/conf/wrapper.conf
COPY conf/sonar.properties /opt/sonarqube-4.4/conf/sonar.properties

ADD plugins.sh /tmp/plugins.sh
WORKDIR /opt/sonarqube-4.4/extensions/downloads
RUN /tmp/plugins.sh

EXPOSE 9000

ENV SONAR_USER sonar
ENV SONAR_PASSWORD sonar
ENV SONAR_JDBC_URL jdbc:h2:tcp://localhost:9092/sonar
ENV SONAR_LOG_LEVEL DEBUG

ENTRYPOINT ["/opt/sonarqube-4.4/bin/linux-x86-64/sonar.sh"]
CMD ["console"]
