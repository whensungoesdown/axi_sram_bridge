#!/bin/bash
./clean.sh > /dev/null

vlib.exe work
vmap.exe work work

vlib.exe altera_mf_ver
vmap.exe altera_mf_ver altera_mf_ver

#vlog -work altera_mf_ver -f soc1.f
vlog.exe +incdir+../../rtl -f files.f

#vlog -reportprogress 300 -work altera_mf_ver ~/intelFPGA_lite/19.1/quartus/eda/sim_lib/altera_mf.v -f soc1.f

vsim.exe -c -novopt -do sim.do top_tb -wlf result.wlf
