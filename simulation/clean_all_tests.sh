#!/bin/bash
echo clean tests
echo

cd test0_read
echo "test0_read"
./clean.sh
echo ""
cd ..

cd test1_write_read_long_ready
echo "test1_write_read_long_ready"
./clean.sh
echo ""
cd ..

cd test2_write_read_short_ready
echo "test2_write_read_short_ready"
./clean.sh
echo ""
cd ..
