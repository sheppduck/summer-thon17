#pull centos 7

FROM centos:7

# install all the things we need
RUN yum install -y bind-utils
RUN yum install -y wget
RUN yum install -y zip
RUN yum install -y unzip
RUN mkdir /var/tmp/performance
RUN mkdir /var/tmp/ptxbom

# copy in files
# RUN yum install -y nmap-ncat-6.40-7.el7.x86_64
COPY docker-entrypoint.sh /
COPY ./performance/artifacts/* /var/tmp/performance/
COPY *.jsonld /var/tmp/ptxbom/


ENTRYPOINT ["/docker-entrypoint.sh"]



