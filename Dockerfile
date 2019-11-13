FROM python:3

################################################################################
# docker-pygit2
# github.com/mikechernev/docker-pygit2/
#
ENV LIBGIT_VERSION 0.28.0

# Cmake is a dependency for building libgit2
RUN apt-get update && apt-get install -y cmake \
# Downloading and building libgit2
    && wget https://github.com/libgit2/libgit2/archive/v${LIBGIT_VERSION}.tar.gz \
    && tar xzf v${LIBGIT_VERSION}.tar.gz \
    && cd libgit2-${LIBGIT_VERSION} \
    && cmake . \ 
    && make \
    && make install \
# The python wrapper for libgit2
    && pip install pygit2 \
# Required for updating the libs
    && ldconfig
#
################################################################################

################################################################################
# docker-git-annex
#

ENV DEBIAN_FRONTEND noninteractive
RUN  \
  # Add neuro.debian.net repository
  wget \
    -O /etc/apt/sources.list.d/neurodebian.sources.list \
    http://neuro.debian.net/lists/bionic.us-nh.full \
  && apt-key adv --recv-keys --keyserver hkp://ipv4.pool.sks-keyservers.net:11371 0xA5D32F012649A5A9 \
  # Install git-annex
  && apt-get update &&  apt-get install -y \
    git-annex-standalone \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

#
################################################################################

################################################################################
# git-annex-adapter
#

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY requirements.txt /usr/src/app/
RUN pip install --no-cache-dir -r requirements.txt

COPY . /usr/src/app
RUN python -m setup install

#
################################################################################

