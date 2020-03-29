FROM ubuntu:18.04
RUN apt-get update && apt-get -y install apache2 && apt-get install default-jdk -y
#&& apt-get install chromium-browser -y && apt-get install chromium-chromedriver -y && apt-get install default-jdk -y
ENV TZ=US
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get install -y git curl php libapache2-mod-php 
#RUN apt-get install libapache2-mod-php -y

# Configure apache
RUN rm /var/www/html/index.html
RUN a2enmod rewrite
RUN chown -R www-data:www-data /var/www
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
EXPOSE 80
COPY src/ /var/www/html
#COPY website-AWS-Jenkins-Docker-Selenium/websitetestin-selenium.jar /home
EXPOSE 8000
#RUN rm /var/www/html/index.html
CMD [ "php", "/var/www/html/index.php" ]
#ENTRYPOINT ["/var/www/html/index.php"]
#CMD echo "ServerName localhost" >> /etc/apache2/apache2.conf
#RUN chown -R www-data:www-data /var/www/html && a2enmod rewrite && service apache2 restart
CMD echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN service apache2 restart
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

