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
CMD cp -r . /var/www/termpage/
RUN cd /etc/apache2/sites-available
RUN cp 000-default.conf termpage.conf
RUN a2ensite termpage.conf
RUN a2dissite 000-default.conf
RUN systemctl reload apache2
EXPOSE 80
