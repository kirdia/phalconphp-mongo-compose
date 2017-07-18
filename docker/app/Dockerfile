#
# Application Core Container
#
# Pull base image
FROM debian:jessie
LABEL maintainer kirdia

ARG cphalcon_version

RUN apt-get update && apt-get -y install apache2 && apt-get clean

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

RUN /usr/sbin/a2ensite default-ssl
RUN /usr/sbin/a2enmod ssl

RUN apt-get update && apt-get -y install php5 php5-dev php5-mysql pkg-config mlocate g++ vim nano && apt-get clean
RUN pecl install mongodb
RUN /usr/sbin/a2dismod 'mpm_*' && /usr/sbin/a2enmod mpm_prefork

ENV PROVISION_CONTEXT "development"

RUN apt-get update && apt-get install -y \
		$PHPIZE_DEPS \
		ca-certificates \
		curl \
		libedit2 \
		libsqlite3-0 \
		libxml2 \
		xz-utils \
	--no-install-recommends && rm -r /var/lib/apt/lists/*

# Compile Phalcon
RUN set -xe && \
        curl -LO https://github.com/phalcon/cphalcon/archive/v${cphalcon_version}.tar.gz && \
        tar xzf v${cphalcon_version}.tar.gz && cd cphalcon-${cphalcon_version}/build && ./install && \
        echo "extension=phalcon.so" > /etc/php5/mods-available/phalcon.ini && \
        cd ../.. && rm -rf v${cphalcon_version}.tar.gz cphalcon-${cphalcon_version} && \
        # Insall Phalcon Devtools, see https://github.com/phalcon/phalcon-devtools/
        curl -LO https://github.com/phalcon/phalcon-devtools/archive/v${cphalcon_version}.tar.gz && \
        tar xzf v${cphalcon_version}.tar.gz && \
        mv phalcon-devtools-${cphalcon_version} /usr/local/phalcon-devtools && \
        ln -s /usr/local/phalcon-devtools/phalcon.php /usr/local/bin/phalcon


ENV COMPOSER_HOME /root/composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN /usr/sbin/php5enmod phalcon

RUN apt-get update && apt-get -y install php5-curl && rm -rf /var/lib/apt/lists/*

COPY conf/apache2.conf /etc/apache2/
COPY conf/default /etc/apache2/sites-available/000-default.conf
COPY conf/php.ini /etc/php5/apache2/
RUN a2enmod rewrite
RUN mkdir -p /var/log/phalcon && chown www-data.www-data /var/log/phalcon
RUN echo "deb http://repo.mysql.com/apt/debian/ jessie mysql-5.6" > /etc/apt/sources.list.d/mysql.list
RUN apt-get update && \
	apt-get install -y --force-yes  mysql-client libsqlite3-dev

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/apache2/access.log \
    && ln -sf /dev/stderr /var/log/apache2/error.log \
    && ln -sf /dev/stdout /var/log/phalcon/log
WORKDIR /var/www/

ADD bin/open.sh /open.sh
RUN chmod +x /open.sh
CMD ["/open.sh"]