FROM ubuntu:14.04
MAINTAINER Aist 
RUN apt-get update && apt-get install -y \
    apache2 \
    php5-cli php5-mysql php5-mcrypt php5-curl libapache2-mod-php5 && \
    rm -rf /var/lib/apt/lists/* && \
    php5enmod mcrypt && \
    a2enmod php5

RUN sed -i 's/short_open_tag = Off/short_open_tag = On/g' /etc/php5/apache2/php.ini

# Define working directory.
WORKDIR /

VOLUME "/var/www"
VOLUME "/tmp"

RUN echo '#!/bin/bash' > /init.sh 
RUN echo 'service apache2 start' >> /init.sh
RUN echo 'tail -f /var/log/apache2/access.log' >> /init.sh
RUN chmod +x /init.sh

# Define default command.
CMD ["/init.sh"]