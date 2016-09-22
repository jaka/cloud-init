FROM nginx

RUN apt-get update
RUN apt-get install -y spawn-fcgi

ADD php-fastcgi /root/php-fastcgi
RUN mkdir /var/run/php-fastcgi

ADD php5_5.6.25-3fs_amd64.deb /root/php5.deb
RUN dpkg -i /root/php5.deb
RUN rm /root/php5.deb

ADD default.conf /etc/nginx/conf.d/default.conf

ADD run.sh /root/run.sh

ADD www /www

CMD ["/root/run.sh"]
