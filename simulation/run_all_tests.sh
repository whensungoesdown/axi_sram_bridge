#!/bin/bash
echo run tests
echo

cd test0_read
echo "test0_read"
./simulate.sh | grep PASS
echo ""
cd ..

cd test1_write_read_long_ready
echo "test1_write_read_long_ready"
./simulate.sh | grep PASS
echo ""
cd ..

cd test2_write_read_short_ready
echo "test2_write_read_short_ready"
./simulate.sh | grep PASS
echo ""
cd ..

cd test3_write_read_read_rready_always1
echo "test3_write_read_read_rready_always1"
./simulate.sh | grep PASS
echo ""
cd ..

