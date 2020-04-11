FROM php:7.4-cli

RUN apt-get update
RUN apt-get install -y --fix-missing libmcrypt-dev libfreetype6-dev libjpeg62-turbo-dev libcurl4-openssl-dev libicu-dev libldap2-dev libldb-dev wget git curl openssh-server msmtp imagemagick libmagickwand-dev zlib1g-dev unzip libsqlite3-0 libpq-dev libsqlite3-dev supervisor libgearman-dev software-properties-common ruby-dev rubygems ruby gnupg2 apt-transport-https libxml2-dev libzip-dev

RUN ln -s /usr/lib/x86_64-linux-gnu/libldap.so /usr/lib/libldap.so \
    && ln -s /usr/lib/x86_64-linux-gnu/liblber.so /usr/lib/liblber.so
RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql
RUN docker-php-ext-install -j$(nproc) iconv gd pdo pdo_mysql pdo_pgsql pdo_sqlite curl zip json intl ldap opcache mysqli soap
RUN pecl install imagick \
    && docker-php-ext-enable imagick
RUN curl -sSL -o php7-memcache.zip https://github.com/websupport-sk/pecl-memcache/archive/NON_BLOCKING_IO_php7.zip \
    && unzip php7-memcache \
    && cd pecl-memcache-NON_BLOCKING_IO_php7 \
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
RUN pecl channel-update pecl.php.net \
    && pecl install xdebug-2.9.3 \
    && docker-php-ext-enable xdebug \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_connect_back=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.idekey=PHPSTORM" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_port=9001" >> /usr/local/etc/php/conf.d/xdebug.ini

RUN apt-get --purge remove -y ruby*

RUN gpg --no-tty --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
RUN curl -sSL https://rvm.io/mpapis.asc | gpg --no-tty --import -
RUN curl -L https://get.rvm.io | bash -s stable
RUN echo 'source /usr/local/rvm/scripts/rvm' >> /etc/bash.bashrc
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm install 2.4.2"
RUN /bin/bash -l -c "rvm use ruby-2.4.2"
RUN /bin/bash -l -c "rvm @global do gem install sass -v 3.4.18"

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs npm
RUN npm cache clean -f
RUN npm install -g n
RUN n stable
RUN npm install -g less sass less-loader css-loader style-loader grunt gulp gulp-cli
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn


RUN echo "sendmail_path = /usr/sbin/msmtp -t" > /usr/local/etc/php/conf.d/sendmail.ini && \
    echo "account mailcatcher\nhost mailcatcher\nport 1025\ntls off\n\naccount default : mailcatcher" > /etc/msmtprc

RUN pecl install oauth \
    && docker-php-ext-enable oauth
RUN pecl install apcu \
    && docker-php-ext-enable apcu
RUN apt-get -y install gettext
RUN docker-php-ext-install intl
RUN docker-php-ext-install gettext
RUN docker-php-ext-install -j$(nproc) bz2

EXPOSE 9000
