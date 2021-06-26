# syntax=docker/dockerfile:1

FROM ubuntu:focal
CMD echo 'Installing Dependencies'
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    git-all \
    apache2 \
    && rm -rf /var/lib/apt/lists/*
CMD echo 'Setting up Webpage'
RUN mkdir /var/www/termpage
RUN git clone https://github.com/confused-Techie/TermPage-Docker
RUN cp TermPage-Docker/termpage.conf /etc/apache2/sites-available/termpage.conf
RUN cp -r TermPage-Docker/ /var/www/termpage/
RUN a2ensite termpage.conf
RUN a2dissite 000-default.conf
RUN chmod 0755 ./TermPage-Docker/apache_wrapper.sh
RUN chmod 0755 ./TermPage-Docker/apache_startup.sh
CMD ["bash", "./TermPage-Docker/apache_wrapper.sh"]
EXPOSE 80
VOLUME ["/var/www/termpage"]
