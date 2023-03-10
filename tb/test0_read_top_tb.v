//`include "../rtl/defines.vh"

`timescale 1ns / 1ps
//`timescale 1ns / 1ns

module top_tb(
   );

   reg clk;
   reg resetn;

   initial
      begin
	 $display("Start ...");
	 clk = 1'b1;
	 resetn = 1'b0;
 
	 #32;
	 resetn = 1'b1;

	 
	 force u_top.fake_cpu.araddr = 32'h0;
	 force u_top.fake_cpu.arvalid = 1'b1;

	 force u_top.fake_cpu.rready = 1'b0;
	 #10
	 //release u_top.fake_cpu.araddr;
	 force u_top.fake_cpu.arvalid = 1'b0;

	 #50
	 force u_top.fake_cpu.rready = 1'b1;
	 #10
	 force u_top.fake_cpu.rready = 1'b0;
      end

   always #5 clk=~clk;
   

   top u_top (
      .clk      (clk      ),
      .resetn   (resetn   )
      );

   always @(negedge clk)
      begin
	 $display("+");
	 $display("reset %b", resetn);

	 if (1'b1 === u_top.fake_cpu.arready)
	    begin
	       $display("top.fake_cpu.arready === 1");
	    end
	 
	 if (1'b1 === u_top.fake_cpu.axi_rd_ret)
	    begin
	       $display("read back data 0x%x", u_top.fake_cpu.rdata);
	    end
      end
   
endmodule // top_tb
