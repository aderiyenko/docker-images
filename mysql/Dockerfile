FROM mysql:5.6

RUN apt-get update

RUN \
	DEBIAN_FRONTEND=noninteractive \
		apt-get -y install \
                        supervisor \
                        wget \
                        python-pip \
	&& \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/

RUN pip install supervisor-stdout

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN wget -c -O mysql-proxy.tar.gz https://downloads.mysql.com/archives/get/file/mysql-proxy-0.8.5-linux-glibc2.3-x86-64bit.tar.gz \ 
        && mkdir /root/mysql-proxy \
	&& tar -zxvf mysql-proxy.tar.gz -C /root/mysql-proxy --strip 1 
ADD proxy.lua /root/

EXPOSE 3306
EXPOSE 4040

CMD ["/usr/bin/supervisord"]
