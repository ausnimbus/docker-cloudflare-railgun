FROM  openshift/base-centos7

MAINTAINER AusNimbus <support@ausnimbus.com.au>

LABEL io.k8s.display-name="Railgun Server" \
      io.k8s.description="Cloudflare Railgun Server."

EXPOSE 2408

RUN rpm -ivh http://pkg.cloudflare.com/cloudflare-release-latest.el7.rpm && \
    yum install -y railgun-stable && \
    yum clean all

RUN touch /var/log/railgun/panic.log && \
    chown -R 1001:0 /var/log/railgun /var/run/railgun /etc/railgun && \
    chmod -R a+rwx /var/log/railgun && \
    chmod -R a+rwx /var/run/railgun && \
    chmod -R a+rwx /etc/railgun

COPY railgun-startup /usr/bin/

USER 1001
CMD ["railgun-startup"]
