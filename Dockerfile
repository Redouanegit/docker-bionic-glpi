FROM ubuntu:bionic

RUN apt-get update
RUN apt-get install -y apache2

RUN su 

RUN rm -rf /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime

RUN apt-get install -y software-properties-common \
  && apt-get update

RUN apt-get install -y --force-yes \
  wget \
  php \
  php-mysql \
  php-ldap \
  php-xmlrpc \
  curl \
  php-curl \
  php-gd \
  php-mbstring \
  php-xml \
  php-apcu \
  php-imap \ 
  php-cas

RUN a2enmod rewrite && service apache2 stop
WORKDIR /var/www/html
COPY start.sh /opt/
RUN chmod +x /opt/start.sh
RUN usermod -u 1000 www-data
CMD /opt/start.sh
EXPOSE 80
