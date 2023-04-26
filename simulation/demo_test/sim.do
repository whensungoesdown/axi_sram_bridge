# list all signals in decimal format
add list -decimal *

#change radix to symbolic
radix -symbolic

#add wave *
#add wave u_top.clk
#add wave u_top.resetn

add wave -position end  sim:/top_tb/clk
add wave -position end  sim:/top_tb/resetn

add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/m_arid
add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/m_araddr
add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/m_arsize
add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/m_arvalid
add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/m_arready

add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/m_rdata
add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/m_rlast
add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/m_rvalid
add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/m_rready

add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/m_arvalid
add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/m_arready
add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/ar_enter
add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/r_retire
add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/busy
add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/m_rvalid
add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/m_rready
add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/m_rdata

add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/m_awid
add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/m_awaddr
add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/m_awsize
add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/m_awvalid
add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/m_awready

add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/m_wdata
add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/m_wstrb
add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/m_wlast
add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/m_wvalid
add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/m_wready

add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/m_bid
add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/m_bresp
add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/m_bready
add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/m_bvalid

add wave -position end  sim:/top_tb/u_top/ram_raddr
add wave -position end  sim:/top_tb/u_top/ram_rdata
add wave -position end  sim:/top_tb/u_top/ram_ren
add wave -position end  sim:/top_tb/u_top/ram_waddr
add wave -position end  sim:/top_tb/u_top/ram_wdata
add wave -position end  sim:/top_tb/u_top/ram_wen


add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/busy_reg/din
add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/busy_reg/rst_l
add wave -position end  sim:/top_tb/u_top/u_axi_sram_bridge/busy_reg/q

add wave -position end  sim:/top_tb/u_top/fake_cpu/u_axi_interface/inst_req
add wave -position end  sim:/top_tb/u_top/fake_cpu/u_axi_interface/arvalid_nxt
add wave -position end  sim:/top_tb/u_top/fake_cpu/u_axi_interface/arvalid_tmp
add wave -position end  sim:/top_tb/u_top/fake_cpu/u_axi_interface/inst_req_delay1
add wave -position end  sim:/top_tb/u_top/fake_cpu/u_axi_interface/arvalid
add wave -position end  sim:/top_tb/u_top/fake_cpu/u_axi_interface/inst_valid
add wave -position end  sim:/top_tb/u_top/fake_cpu/u_axi_interface/inst_rdata
add wave -position end  sim:/top_tb/u_top/fake_cpu/inst_addr
add wave -position end  sim:/top_tb/u_top/fake_cpu/inst_addr_nxt

run 500ns

# read in stimulus
#do stim.do

# output results
write list test.lst

# quit the simulation
quit -f

