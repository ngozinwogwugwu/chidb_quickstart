# chidb_quickstart
Use this as a quickstart for chidb if you want to spin up a docker container. It should take care of everything on the [chidb installation page](http://chi.cs.uchicago.edu/chidb/installing.html)

## get started:
Use this command to spin up a dockerfile
``` bash
docker build -t chidb_quickstart . && docker container run -it chidb_quickstart /bin/sh
```
Great. Now you have a container with:
- automake
- autoconf
- libtool
- Check Unit Test Framework (http://check.sourceforge.net/).
- lex
- yacc
- editline library, including the header files.

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
use `crtl-c` to get out of there

## Install check
Use check for automated tests
- [from the check documentation](https://libcheck.github.io/check/web/install.html#linuxsource)
``` bash
git clone https://github.com/libcheck/check.git
cd check/
autoreconf --install
./configure
make
make check
make install
```
