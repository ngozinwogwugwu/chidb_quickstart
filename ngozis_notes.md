# Ngozi's chidb notes
I'm quite new to chidb, and very rusty on c, so I'll record tips, tricks and realizations here. Maybe I'll write a blogpost one day.

## Importance of test files
The [chidb cource](http://chi.cs.uchicago.edu/chidb/assignment_btree.html) looks like it was meant to be taken with a little guidance. It really does just drop you into the problem solving. Here's an example of an assignment question:

*Step 1: Opening a chidb file* Implement the following functions:

``` c
int chidb_Btree_open(const char *filename, chidb *db, BTree **bt)
int chidb_Btree_close(BTree *bt);
```
If this looks a bit intimidating, you can look to for guidance is the automated tests. These live in `tests` directory. Since they'll basically tell you what they're looking for, you'll get a lot of information from them. For example, here's the test file for the question above:
``` c
START_TEST (test_1a_1)
{
    int rc;
    chidb *db;

    char *fname = create_copy(TESTFILE_STRINGS1, "btree-test-1a-1.dat");

    db = malloc(sizeof(chidb));
    rc = chidb_Btree_open(fname, db, &db->bt);
    ck_assert(rc == CHIDB_OK);
    ck_assert(db->bt->pager->n_pages == 5);
    ck_assert(db->bt->pager->page_size == 1024);
    rc = chidb_Btree_close(db->bt);
    ck_assert(rc == CHIDB_OK);
    delete_copy(fname);
    free(db);
}
END_TEST
```
You can find this [here](https://github.com/uchicago-cs/chidb/blob/master/tests/check_btree_1a.c#L6), by the way.

This test file might answer a few questions, like:
- where can I get an example test file?
- what's the default page size
- I'm new/rusty when it comes to C. How do I need to organize this data?

The directions for these tests can be found on [chidb's test page](http://chi.cs.uchicago.edu/chidb/testing.html#automated-tests), and you must be in the chidb directory for the tests to do anything. For instance:
``` bash
cd chidb
CK_RUN_CASE="Step 1a: Opening an existing chidb file" make check
```
should print out something like
``` bash
make --no-print-directory check-am
make --no-print-directory tests/check_btree tests/check_dbrecord tests/check_dbm tests/check_pager tests/check_utils
make[2]: 'tests/check_btree' is up to date.
make[2]: 'tests/check_dbrecord' is up to date.
make[2]: 'tests/check_dbm' is up to date.
make[2]: 'tests/check_pager' is up to date.
make[2]: 'tests/check_utils' is up to date.
make --no-print-directory check-TESTS
FAIL: tests/check_btree
PASS: tests/check_dbrecord
PASS: tests/check_dbm
PASS: tests/check_pager
PASS: tests/check_utils
============================================================================
Testsuite summary for chidb 1.0
============================================================================
# TOTAL: 5
# PASS:  4
# SKIP:  0
# XFAIL: 0
# FAIL:  1
# XPASS: 0
# ERROR: 0
============================================================================
See ./test-suite.log
Please report to do-not-email@example.org
============================================================================
make[3]: *** [Makefile:1692: test-suite.log] Error 1
make[2]: *** [Makefile:1800: check-TESTS] Error 2
make[1]: *** [Makefile:2032: check-am] Error 2
make: *** [Makefile:2034: check] Error 2
```
Now it's your job to fill in the code and make the tests pass

## Handy built-in utilities
The course didn't mention this, but the [utils file](https://github.com/uchicago-cs/chidb/blob/master/src/libchidb/util.c) is already full of handy functions.
- **get4byte/put4byte**:  Read or write a four-byte big-endian integer value.
- **chidb_BTree_recordPrinter/chidb_BTree_stringPrinter**: prints out BTree stuff
- **chidb_tokenize**

## hexdump
If you want a good way to view a database file, you can use [hexdump](http://man7.org/linux/man-pages/man1/hexdump.1.html). When you use this on a database, you should see something like this:
``` bash
bash-4.4# hexdump -C tests/files/generated/btree-test-1a-1.dat
00000000  53 51 4c 69 74 65 20 66  6f 72 6d 61 74 20 33 00  |SQLite format 3.|
00000010  04 00 01 01 00 40 20 20  00 00 00 00 00 00 00 00  |.....@  ........|
00000020  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 01  |................|
```

for the first 16 bytes of data:
```bash
hexdump -C -n 16 tests/files/generated/btree-test-1a-3.dat
```
for the next (offset by 16) two bytes of data, as a decimal
``` bash
hexdump -d -s 16 -n 2 tests/files/generated/btree-test-1a-1.dat
```


## gdb
I'll become more effective if I use a debugger, so let's install it using [this gdb tutorial](http://www.gdbtutorial.com/tutorial/how-install-gdb):
``` bash
# get all the stuff
apk add gdb
wget "http://ftp.gnu.org/gnu/gdb/gdb-7.11.tar.gz"
tar -xvzf gdb-7.11.tar.gz

# configure, make, install
cd gdb-7.11
./configure
make
make install

# check to see if you really have it
gdb --version
```


