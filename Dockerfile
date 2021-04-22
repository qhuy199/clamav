FROM trunglt/centos7:latest

# Initial Install Clamav
RUN wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    yum install -y epel-release-latest-7.noarch.rpm && \
    yum install -y clamav clamd && \
    yum clean all

# Permission juggling
 RUN mkdir /var/run/clamav && \
    chown root:root /var/run/clamav && \
    chmod 750 /var/run/clamav

COPY bootstrap.sh /

EXPOSE 3310

RUN chown root:root /bootstrap.sh && \
    chmod u+x /bootstrap.sh    

USER root

CMD ["/bootstrap.sh"]

