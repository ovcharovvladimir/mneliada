#!/bin/sh
make test | awk 'BEGIN { a=0 } /digraph/ { a=1 } { if (a) print $0 } /^}$/ { a=0 }' | dot -Tpng > `mktemp -u`.png
