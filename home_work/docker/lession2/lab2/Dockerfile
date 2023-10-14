FROM ubuntu:20.04

RUN apt update -y

RUN apt install -y curl

RUN apt install -y openjdk-17-jdk

WORKDIR /tmp

RUN curl -O https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.80/bin/apache-tomcat-9.0.80.tar.gz

RUN mkdir /opt/tomcat

WORKDIR /opt/tomcat

RUN tar xzvf /tmp/apache-tomcat-9.0.*tar.gz -C /opt/tomcat --strip-components=1

CMD [ "/opt/tomcat/bin/catalina.sh", "run" ]