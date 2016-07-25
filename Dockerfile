FROM rmkn/php
MAINTAINER rmkn

RUN yum -y install unzip php-pdo
RUN curl -o /tmp/wordpress.tar.gz -SL https://ja.wordpress.org/latest-ja.tar.gz \
	&& tar xzf /tmp/wordpress.tar.gz -C /var/www/html/ --strip=1 \
	&& rm /tmp/wordpress.tar.gz \
	&& cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php \
	&& chmod 777 /var/www/html \
	&& chown -R apache. /var/www/html/*
RUN curl -o /tmp/sqlite-integration.zip -SL https://downloads.wordpress.org/plugin/sqlite-integration.1.8.1.zip \
	&& unzip /tmp/sqlite-integration.zip -d /var/www/html/wp-content/plugins \
	&& rm /tmp/sqlite-integration.zip \
	&& chown -R apache. /var/www/html/wp-content/plugins/*
RUN cp /var/www/html/wp-content/plugins/sqlite-integration/db.php /var/www/html/wp-content

EXPOSE 80

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

