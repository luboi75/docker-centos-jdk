FROM centos
MAINTAINER Lubo Ivanovic <luboi75@googlemail.com>

ADD opt/ /opt/

RUN chmod +x /opt/installJDK.sh; \
    yum install -y wget; \
    /opt/installJDK.sh; \
    rm -f /opt/installJDK.sh; \
    java -version

CMD ["/bin/bash"] 

