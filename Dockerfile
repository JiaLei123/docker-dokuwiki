FROM ubuntu:14.04
RUN sudo apt-get update && sudo apt-get upgrade
RUN sudo apt-get install apache2 libapache2-mod-php php-xml
RUN sudo a2enmod rewrite

RUN cd /var/www
RUN wget https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz
RUN tar xzf dokuwiki-stable.tgz
RUN sudo mv dokuwiki-*/ dokuwiki
RUN sudo chown -R www-data:www-data /var/www/dokuwiki
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

