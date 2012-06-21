#!/bin/sh

gcc -I/usr/local/include/postgresql/server -I/usr/local/include -fPIC -c translit.c
gcc -shared -o translit.so translit.o

