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
00000030  00 00 4e 20 00 00 00 00  00 00 00 01 00 00 00 00  |..N ............|
00000040  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
00000060  00 00 00 00 05 00 76 00  03 03 e8 00 00 00 00 02  |......v.........|
00000070  03 f0 03 f8 03 e8 00 00  00 00 00 00 00 00 00 00  |................|
00000080  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
000003e0  00 00 00 00 00 00 00 00  00 00 00 05 80 80 87 68  |...............h|
000003f0  00 00 00 04 80 80 80 07  00 00 00 03 80 80 80 23  |...............#|
00000400  0d 00 10 00 04 01 e0 00  03 78 02 f0 02 68 01 e0  |.........x...h..|
00000410  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
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
I'll become more effective if I use a debugger, so more to come here.


