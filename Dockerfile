FROM ubuntu:14.04
RUN apt-get -y update && sudo apt-get -y upgrade
RUN apt-get -y install apache2 
RUN sudo apt-get -y install libapache2-mod-php5 
#RUN sudo apt-get -y install php-xml
RUN sudo a2enmod rewrite
RUN apt-get -y install wget
RUN cd /var/www
WORKDIR /var/www
RUN wget https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz
RUN tar xzf dokuwiki-stable.tgz
RUN mv dokuwiki-*/ dokuwiki
RUN chown -R www-data:www-data /var/www/dokuwiki
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
COPY apache2.conf /etc/apache2/apache2.conf

# Set environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_LOCK_DIR /var/run/apache2

EXPOSE 80

CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]

