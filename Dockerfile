FROM ubuntu:14.04
MAINTAINER Stas Kraev "mail@kraev.me"

RUN apt-get update && \
    apt-get install -q -y openjdk-7-jre-headless curl wget && \
    apt-get clean
RUN [ "/usr/bin/wget", "https://get.docker.com/ubuntu/", "-O", "/tmp/docker.sh" ]
RUN chmod +x /tmp/docker.sh && sleep 1 && \
    /tmp/docker.sh && \
    service docker stop || : && \
    rm /etc/init/docker.conf && \
    useradd  -G docker -m jenkins  && \
    mkdir /jenkins && \
    chown jenkins /jenkins

ADD http://mirrors.jenkins-ci.org/war/1.602/jenkins.war /home/jenkins/jenkins.war
RUN chown jenkins /home/jenkins/jenkins.war && \
    sleep 1 && \
    chmod 644 /home/jenkins/jenkins.war 
ENV JENKINS_HOME /jenkins

USER jenkins
ENTRYPOINT ["java", "-jar", "/home/jenkins/jenkins.war"]
EXPOSE 8080
CMD [""]
