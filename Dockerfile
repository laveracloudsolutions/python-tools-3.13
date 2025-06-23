# Build a virtualenv using the appropriate Debian release
# * Install python3-venv for the built-in Python3 venv module (not installed by default)
# * Install gcc libpython3-dev to compile C Python modules
# * In the virtualenv: Update pip setuputils and wheel to support building new packages
FROM ghcr.io/laveracloudsolutions/python:3.13-slim-bookworm AS build
ENV PYTHONUNBUFFERED=1
ENV DEBIAN_FRONTEND=noninteractive

# Debian package install
RUN apt-get update && \
    apt-get install --no-install-suggests --no-install-recommends --yes \
    curl=7.88.*  \
    git=1:2.*  \
    gcc=4:12.*  \
    libpython3-dev=3.*  \
    python3-venv=3.* \
    openssh-client=1:9.*

# Python init
RUN python3 -m venv /venv && \
    /venv/bin/pip install --upgrade pip setuptools wheel

# Install Java & NodeJS (Sonarqube for vscode)
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
RUN apt-get install -y openjdk-17-jre=17.*
RUN curl -fsSL https://deb.nodesource.com/setup_22.x -o nodesource_setup.sh && \
    bash nodesource_setup.sh && \
    apt-get install -y nodejs=22.*
