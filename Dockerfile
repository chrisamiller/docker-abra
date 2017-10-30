FROM openjdk:7-jre
MAINTAINER Chris Miller <c.a.miller@wustl.edu>
LABEL abra - Assembly Based ReAligner

RUN apt-get -y update && apt-get install -y wget bwa
RUN mkdir /opt/abra/
RUN cd /opt/abra/ && wget https://github.com/mozack/abra/releases/download/v0.97/abra-0.97-SNAPSHOT-jar-with-dependencies.jar
RUN echo 'java -jar /opt/abra/abra-0.97-SNAPSHOT-jar-with-dependencies.jar' >/usr/bin/abra && chmod +x /usr/bin/abra

# needed for MGI data mounts
RUN apt-get update && apt-get install -y libnss-sss && apt-get clean all

#set timezone to CDT
#LSF: Java bug that need to change the /etc/timezone.
#/etc/localtime is not enough.
RUN ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime && \
    echo "America/Chicago" > /etc/timezone && \
    dpkg-reconfigure --frontend noninteractive tzdata

CMD "/bin/bash"
