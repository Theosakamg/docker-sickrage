FROM lsiobase/python:3.11

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io-fork version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="theoskakamg7"

# set python to use utf-8 rather than ascii
ENV PYTHONIOENCODING="UTF-8"

RUN \
 echo "**** install packages ****" && \
 apk add --no-cache --upgrade && \
 apk add --no-cache \
	g++ \
	gcc \
	python2-dev \
	nodejs && \
 echo "**** install pip packages ****" && \
 pip install --no-cache-dir -U \
    pycrypto && \
 echo "**** clean up ****" && \
 rm -rf \
	/root/.cache \
	/tmp/*

RUN \
 echo "**** install app ****" && \
 git clone --depth=1 -b feature/ddlprovider https://github.com/Theosakamg/SickChill.git /app/sickchill && \
 rm -rf /app/sickchill/.git

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 8081
VOLUME /config /downloads /tv

