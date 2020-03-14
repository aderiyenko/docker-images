FROM php:7.1-cli

RUN apt-get update
RUN apt-get install -y --fix-missing libmcrypt-dev libfreetype6-dev libjpeg62-turbo-dev libpng12-dev libcurl4-openssl-dev libicu-dev libldap2-dev libldb-dev ruby-dev rubygems ruby nodejs npm wget git curl openssh-server ssmtp imagemagick libmagickwand-dev zlib1g-dev unzip libsqlite3-0 libpq-dev libsqlite3-dev libgearman-dev apt-transport-https
RUN ln -s /usr/lib/x86_64-linux-gnu/libldap.so /usr/lib/libldap.so \
    && ln -s /usr/lib/x86_64-linux-gnu/liblber.so /usr/lib/liblber.so
RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql
RUN docker-php-ext-install -j$(nproc) iconv mcrypt gd pdo pdo_mysql pdo_pgsql pdo_sqlite curl zip json intl ldap opcache mysqli
RUN pecl install imagick \
    && docker-php-ext-enable imagick
RUN curl -sSL -o php7-memcache.zip https://github.com/websupport-sk/pecl-memcache/archive/php7.zip \
    && unzip php7-memcache \
    && cd pecl-memcache-php7 \
    && /usr/local/bin/phpize \
    && ./configure --with-php-config=/usr/local/bin/php-config \
    && make \
    && make install \
    && echo "extension=memcache.so" > /usr/local/etc/php/conf.d/ext-memcache.ini \
    && rm -rf /tmp/pecl-memcache-php7 php7-memcache.zip
RUN curl -sSL -o php7-gearman.zip https://github.com/wcgallego/pecl-gearman/archive/master.zip \
    && unzip php7-gearman.zip \
    && cd pecl-gearman-master \
    && /usr/local/bin/phpize \
    && ./configure \
    && make \
    && make install \
    && echo "extension=gearman.so" > /usr/local/etc/php/conf.d/ext-gearman.ini \
    && rm -rf /tmp/gearman-1.1.2 php7-gearman.tgz
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN echo "sendmail_path = /usr/sbin/ssmtp -t" > /usr/local/etc/php/conf.d/sendmail.ini && \
    echo "mailhub=mailcatcher:1025\nUseTLS=NO\nFromLineOverride=YES" > /etc/ssmtp/ssmtp.conf

RUN npm cache clean -f
RUN npm install -g n
RUN n stable
RUN npm install -g less sass less-loader css-loader style-loader grunt webpack
RUN \curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get -y install yarn
RUN pecl install apcu \
    && docker-php-ext-enable apcu
RUN apt-get -y install gettext
RUN docker-php-ext-install intl
RUN docker-php-ext-install gettext
RUN apt-get install -y --fix-missing libxml2-dev
RUN docker-php-ext-install -j$(nproc) soap

RUN pecl install oauth \
    && docker-php-ext-enable oauth


EXPOSE 9000 9001
