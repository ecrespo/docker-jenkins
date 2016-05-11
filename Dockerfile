
FROM debian
MAINTAINER Ernesto Crespo <ecrespo@gmail.com>
RUN apt-get update
RUN apt-get install -y apt-transport-https
RUN apt-get install -y git
RUN apt-get install -y openssh-server openssh-client sudo
RUN apt-get install -y openjdk-7-jdk maven2 
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys  58118E89F3A912897C070ADBF76221572C52609D
RUN sh -c 'echo "deb https://apt.dockerproject.org/repo debian-jessie main" > /etc/apt/sources.list.d/docker.list'
RUN apt-get install -y wget 
RUN wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add -
RUN sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
RUN apt-get update
RUN apt-get install -y docker-engine
RUN apt-get install -y jenkins 
RUN apt-get install -y vim less locate
RUN sh -c 'service docker start'
RUN sh -c 'service jenkins start'
RUN sh -c 'echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers'
RUN sh -c 'curl -L https://github.com/docker/compose/releases/download/1.4.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose; chmod +x /usr/local/bin/docker-compose'
#COPY plugins.txt /usr/share/jenkins/plugins.txt

RUN apt-get clean
EXPOSE 8080 50000 22
ENTRYPOINT ["java","-jar","/usr/share/jenkins/jenkins.war"]
CMD [""]

