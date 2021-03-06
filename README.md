# chidb_quickstart
Use this as a quickstart for chidb if you want to spin up a docker container. It should take care of everything on the [chidb installation page](http://chi.cs.uchicago.edu/chidb/installing.html)

## get started:
Clone this repo and use your terminal to navigate to the chidb_quickstart directory

Use this command to spin up a dockerfile
``` bash
git clone https://github.com/uchicago-cs/chidb.git
docker build -t chidb_quickstart .
docker run -d -it --name chidb_sandbox --mount type=bind,source="$(pwd)"/chidb,target=/app/chidb chidb_quickstart
docker container exec -it chidb_sandbox /bin/sh
```
Great. Now you have a container with:
- automake
- autoconf
- libtool
- Check Unit Test Framework (http://check.sourceforge.net/).
- lex
- yacc
- editline library, including the header files.
- texinfo (needed for later on)

You also have a **chidb** bind mount. Any change you make on your host machine will be reflected in your container, and vice versa.

## The next step is to build chidb
you should be seeing `/app #` as a prompt, which means you're inside the chidb_quickstart docker container.

Type in the following commands to build chidb:
``` bash
cd chidb/
./autogen.sh
./configure
make
```

To start the chidb shell, run this command:
``` bash
./chidb
```
use `crtl-c` to exit the chidb shell. If you want to exit the container (your state should be saved), type in `exit`. If you want to restart it again later on, run the following commands:
``` bash
docker attach chidb_sandbox
```

## Install check
Use check for automated tests
- [from the check documentation](https://libcheck.github.io/check/web/install.html#linuxsource)

TODO: find a way to install:
- tetex-bin (or any texinfo-compatible TeX installation, for documentation)
- POSIX sed

``` bash
git clone https://github.com/libcheck/check.git
cd check/
autoreconf --install
./configure
make
make check
make install
```

## Eventual Cleanup
If you ever want to remove the docker container/image you just created (This will remove them *forever*, so you might want to wait until after you're done with the course), take the following steps:

1. Remove the container
``` bash
docker container rm chidb_sandbox
```

2. Remove the image
``` bash
docker image ls# to get the image ID
docker image rm ###IMAGE_ID###
```
