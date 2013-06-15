# RabbitMQ
#
# VERSION               0.0.1

FROM      ubuntu:12.04
MAINTAINER Mikael Gueck "gumi@iki.fi"

# Make sure that Upstart won't try to start RabbitMQ after installing it
ADD policy-rc.d /usr/sbin/policy-rc.d
RUN chmod +x /usr/sbin/policy-rc.d

# Another way to workaround Upstart problems
# RUN dpkg-divert --local --rename --add /sbin/initctl
# RUN ln -s /bin/true /sbin/initctl

ADD rabbitmq-signing-key-public.asc /tmp/rabbitmq-signing-key-public.asc
RUN apt-key add /tmp/rabbitmq-signing-key-public.asc

RUN echo "deb http://www.rabbitmq.com/debian/ testing main" > /etc/apt/sources.list.d/rabbitmq.list
RUN apt-get update
RUN apt-get -y install rabbitmq-server
RUN /usr/sbin/rabbitmq-plugins enable rabbitmq_management

EXPOSE 5672 15672

CMD ['/usr/sbin/rabbitmq-server']