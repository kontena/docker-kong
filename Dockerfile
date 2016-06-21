FROM centos:7
MAINTAINER Marco Palladino, marco@mashape.com

ENV KONG_VERSION 0.8.3

RUN yum install -y ruby https://github.com/Mashape/kong/releases/download/$KONG_VERSION/kong-$KONG_VERSION.el7.noarch.rpm && \
    yum clean all

COPY config.docker/kong.yml.erb /etc/kong/

ADD setup.sh setup.sh
RUN chmod +x setup.sh

# forward request and error logs to docker log collector
RUN mkdir -p /usr/local/kong/logs \
  && touch /usr/local/kong/logs/access.log \
  && touch /usr/local/kong/logs/error.log \
  && ln -sf /dev/stdout /usr/local/kong/logs/access.log \
	&& ln -sf /dev/stderr /usr/local/kong/logs/error.log

CMD ./setup.sh

EXPOSE 8000 8443 8001 7946
