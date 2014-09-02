FROM dockerfile/ubuntu

# Install Haproxy.
RUN \
  sed -i 's/^# \(.*-backports\s\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get install -y haproxy=1.5.3-1~ubuntu14.04.1 && \
  sed -i 's/^ENABLED=.*/ENABLED=1/' /etc/default/haproxy

# Supervisor
RUN apt-get install -y supervisor && mkdir -p /var/log/supervisor
RUN apt-get install -y python-pip && pip install supervisor-stdout 

RUN  curl -L https://github.com/hashicorp/consul-haproxy/releases/download/v0.1.0/consul-haproxy_linux_amd64 > /consul-haproxy && \
  chmod 777 /consul-haproxy

# Add files.
ADD haproxy.cfg /etc/haproxy/haproxy.cfg
ADD start.bash /haproxy-start
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf 

# Define mountable directories.
VOLUME ["/data", "/haproxy-override"]

# Define working directory.
WORKDIR /etc/haproxy

# Define default command.
CMD ["/usr/bin/supervisord"]

# Expose ports.
EXPOSE 80
EXPOSE 443