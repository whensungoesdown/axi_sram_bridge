module top(
   input  clk
   );

   axi_sram_bridge axi_sram(
      .aclk         (clk      )
      );

endmodule // top
