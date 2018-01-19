FROM ubuntu:14.04
MAINTAINER Jeff jia <sfw123817@qq.com>



RUN apt-get -y update && sudo apt-get -y upgrade && \
    apt-get -y install apache2 libapache2-mod-php5 wget


WORKDIR /var/www

RUN a2enmod rewrite && \
    wget https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz && \
    tar xzf dokuwiki-stable.tgz && \
    mv dokuwiki-*/ dokuwiki && \
    mkdir -p /var/dokuwiki-storage/data && \
    mv /var/www/dokuwiki/data/pages /var/dokuwiki-storage/data/pages && \
    ln -s /var/dokuwiki-storage/data/pages /var/www/dokuwiki/data/pages && \
    mv /var/www/dokuwiki/data/meta /var/dokuwiki-storage/data/meta && \
    ln -s /var/dokuwiki-storage/data/meta /var/www/dokuwiki/data/meta && \
    mv /var/www/dokuwiki/data/media /var/dokuwiki-storage/data/media && \
    ln -s /var/dokuwiki-storage/data/media /var/www/dokuwiki/data/media && \
    mv /var/www/dokuwiki/data/media_attic /var/dokuwiki-storage/data/media_attic && \
    ln -s /var/dokuwiki-storage/data/media_attic /var/www/dokuwiki/data/media_attic && \
    mv /var/www/dokuwiki/data/media_meta /var/dokuwiki-storage/data/media_meta && \
    ln -s /var/dokuwiki-storage/data/media_meta /var/www/dokuwiki/data/media_meta && \
    mv /var/www/dokuwiki/data/attic /var/dokuwiki-storage/data/attic && \
    ln -s /var/dokuwiki-storage/data/attic /var/www/dokuwiki/data/attic && \
    mv /var/www/dokuwiki/conf /var/dokuwiki-storage/conf && \
    ln -s /var/dokuwiki-storage/conf /var/www/dokuwiki/conf



COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
COPY apache2.conf /etc/apache2/apache2.conf

VOLUME ["/var/dokuwiki-storage"]

EXPOSE 80

CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]
