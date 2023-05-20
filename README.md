# axi_sram_bridge
# Simple AXI-lite Sram Bridge

**Developing...**

No burst transaction. xxid is not used. awsize arsize are also ignored. Define the DATA_WIDTH in the RTL code.



## AXI-lite Single Write

A write takes at least 2 cycles.

![axi_sram_bridge_single_write](https://github.com/whensungoesdown/whensungoesdown.github.io/raw/main/_posts/axi_sram_bridge_single_write.png)



## AXI-lite Multiple Write


![axi_sram_bridge_multiple_write](https://github.com/whensungoesdown/whensungoesdown.github.io/raw/main/_posts/axi_sram_bridge_multiple_write.png)


## AXI-lite Single Read

A read takes at least 2 cycles.

![axi_sram_bridge_single_read1](https://github.com/whensungoesdown/whensungoesdown.github.io/raw/main/_posts/axi_sram_bridge_single_read1.png)
![axi_sram_bridge_single_read2](https://github.com/whensungoesdown/whensungoesdown.github.io/raw/main/_posts/axi_sram_bridge_single_read2.png)


# Build

Add "export PATH=$PATH:/mnt/c/intelFPGA_lite/19.1/quartus/bin64" to ~/.bashrc

cd systhesis

cd altera

make 

## For Windows WSL

Change quartus_xx to quartus_xx.exe in makefile.



