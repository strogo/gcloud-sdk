FROM python:2.7
MAINTAINER John Pfeiffer "https://github.org/johnpfeiffer"

# https://cloud.google.com/sdk/docs/quickstart-linux
ENV VERSION 156.0.0
RUN echo ${VERSION}

RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN apt-get update
RUN apt-get install -y lsb-release

# https://cloud.google.com/sdk/docs/quickstart-debian-ubuntu
RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
  echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN apt-get update && apt-get install -y google-cloud-sdk
RUN gcloud --version

ENV GOVERSION 1.8.3
RUN wget https://storage.googleapis.com/golang/go${GOVERSION}.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go${GOVERSION}.linux-amd64.tar.gz
RUN export PATH=$PATH:/usr/local/go/bin
RUN go version

