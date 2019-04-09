FROM alpine:3.7

### install the software requirements for chidb (http://chi.cs.uchicago.edu/chidb/installing.html)
RUN apk add --no-cache \
  automake \
  autoconf \
  libtool \
  check \
  check-dev \
  bison flex \
  gcc \
  alpine-sdk \
  ncurses-dev \
  texinfo \
&& wget 'http://thrysoee.dk/editline/libedit-20190324-3.1.tar.gz' \
&& tar xvf libedit-20190324-3.1.tar.gz \
&& rm libedit-20190324-3.1.tar.gz

WORKDIR /app
ADD . /app

RUN sh install_dependencies

## Want to run this and get a shell? use the command `docker build -t chidb_plus . && docker container run -it chidb_plus /bin/sh`

