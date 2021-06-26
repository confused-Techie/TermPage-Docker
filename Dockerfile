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
RUN cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/termpage.conf
RUN a2ensite termpage.conf
RUN a2dissite 000-default.conf
CMD ./apache_wrapper.sh
EXPOSE 80
VOLUME ["/var/www/termpage"]
