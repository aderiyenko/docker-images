FROM php:5.6-fpm

RUN apt-get update
RUN apt-get install -y --fix-missing libmcrypt-dev libfreetype6-dev libjpeg62-turbo-dev libpng12-dev libcurl4-openssl-dev libicu-dev libldap2-dev libldb-dev nodejs npm wget git curl openssh-server ssmtp imagemagick libmagickwand-dev libsqlite3-0 libpq-dev libsqlite3-dev apt-transport-https libxml2-dev

RUN ln -s /usr/lib/x86_64-linux-gnu/libldap.so /usr/lib/libldap.so \
    && ln -s /usr/lib/x86_64-linux-gnu/liblber.so /usr/lib/liblber.so
RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql
RUN docker-php-ext-install -j$(nproc) iconv mcrypt gd pdo pdo_mysql pdo_pgsql pdo_sqlite curl zip json intl ldap opcache mysqli mysql  soap
RUN pecl channel-update pecl.php.net \ 
    && pecl install xdebug-2.5.0 \
    && docker-php-ext-enable xdebug \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_connect_back=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.idekey=PHPSTORM" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_port=9001" >> /usr/local/etc/php/conf.d/xdebug.ini
RUN pecl install memcache-3.0.8 \
    && docker-php-ext-enable memcache
RUN pecl install imagick \
    && docker-php-ext-enable imagick
RUN npm cache clean -f
RUN npm install -g n
RUN n stable
RUN npm install -g less sass less-loader css-loader style-loader grunt webpack gulp gulp-cli
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get -y install yarn


RUN echo "sendmail_path = /usr/sbin/ssmtp -t" > /usr/local/etc/php/conf.d/sendmail.ini && \
    echo "mailhub=mailcatcher:1025\nUseTLS=NO\nFromLineOverride=YES" > /etc/ssmtp/ssmtp.conf

RUN apt-get --purge remove -y ruby*

RUN gpg --no-tty --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
RUN curl -sSL https://rvm.io/mpapis.asc | gpg --import --no-tty -
RUN curl -L https://get.rvm.io | bash -s stable
RUN echo 'source /usr/local/rvm/scripts/rvm' >> /etc/bash.bashrc
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm install 2.2.2"
RUN /bin/bash -l -c "rvm use 2.2.2"

RUN /bin/bash -l -c "rvm @global do gem install sass -v 3.4.18"
RUN pecl install apcu-4.0.11 \
    && docker-php-ext-enable apcu
RUN apt-get -y install gettext
RUN docker-php-ext-install intl
RUN docker-php-ext-install gettext

EXPOSE 9000
