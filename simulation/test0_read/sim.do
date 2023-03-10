# list all signals in decimal format
add list -decimal *

#change radix to symbolic
radix -symbolic

#add wave *
#add wave u_top.clk
#add wave u_top.resetn

add wave -position end  sim:/top_tb/clk
add wave -position end  sim:/top_tb/resetn
add wave -position end  sim:/top_tb/u_top/fake_cpu/araddr
add wave -position end  sim:/top_tb/u_top/fake_cpu/arvalid
add wave -position end  sim:/top_tb/u_top/fake_cpu/arready
add wave -position end  sim:/top_tb/u_top/fake_cpu/rvalid
add wave -position end  sim:/top_tb/u_top/fake_cpu/rready
add wave -position end  sim:/top_tb/u_top/fake_cpu/rlast

add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/m_arvalid
add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/m_arready
add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/ar_enter
add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/r_retire
add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/busy
add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/m_rvalid
add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/m_rready
add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/m_rdata

add wave -position end  sim:/top_tb/u_top/ram_raddr
add wave -position end  sim:/top_tb/u_top/ram_rdata
add wave -position end  sim:/top_tb/u_top/ram_ren
add wave -position end  sim:/top_tb/u_top/ram_waddr
add wave -position end  sim:/top_tb/u_top/ram_wdata
add wave -position end  sim:/top_tb/u_top/ram_wen


add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/busy_reg/din
add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/busy_reg/rst_l
add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/busy_reg/q

run 500ns

# read in stimulus
#do stim.do

# output results
write list test.lst

# quit the simulation
quit -f
