FROM ubuntu:12.04.5

RUN apt-get update && \
 apt-get install -y php5-fpm nginx supervisor cron && apt-get clean

# configure nginx
COPY vhost.conf /etc/nginx/sites-available/default

RUN mkdir /var/www && cp /usr/share/nginx/www/index.html /var/www/index.html

# configure php5-fpm
RUN sed -i 's|;daemonize = yes|daemonize = no|g' /etc/php5/fpm/php-fpm.conf
RUN sed -i 's|listen = 127.0.0.1:9000|listen = /var/run/php5-fpm.sock|g' /etc/php5/fpm/pool.d/www.conf
RUN sed -i 's|;listen.owner = www-data|listen.owner = www-data|g' /etc/php5/fpm/pool.d/www.conf
RUN sed -i 's|;listen.group = www-data|listen.group = www-data|g' /etc/php5/fpm/pool.d/www.conf

# configure supervisord
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf


EXPOSE 80

CMD ["supervisord"]