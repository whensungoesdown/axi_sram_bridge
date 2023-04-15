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

	 //force u_top.ram_waddr = 32'h0;
	 //force u_top.ram_wdata = 64'h0;
	 //force u_top.ram_wen   = 1'h0;

	 //force u_top.ram_raddr = 32'h0;
	 //force u_top.ram_rdata = 64'h0;
	 //force u_top.ram_ren   = 1'h0;

	 // init 
	 force u_top.fake_cpu.araddr = 32'h0;
	 force u_top.fake_cpu.arvalid = 1'b0;
	 force u_top.fake_cpu.rready = 1'b0;
	 force u_top.fake_cpu.bready = 1'b0;

	 // start singals, action0
	 force u_top.fake_cpu.awid = 4'h0;
	 force u_top.fake_cpu.awsize = 3'h0;
	 force u_top.fake_cpu.awaddr = 32'h0;
	 force u_top.fake_cpu.awvalid = 1'b0;

	 force u_top.fake_cpu.wdata = 64'h0;
	 force u_top.fake_cpu.wlast = 1'b0;
	 force u_top.fake_cpu.wstrb = 4'h0;
	 force u_top.fake_cpu.wvalid = 1'b0;
	 force u_top.fake_cpu.bready = 1'b0;

	 #50

	 
	 

	 // start singals, action0
	 force u_top.fake_cpu.awid = 4'h0;
	 force u_top.fake_cpu.awsize = 3'h2;
	 force u_top.fake_cpu.awaddr = 32'h4;
	 force u_top.fake_cpu.awvalid = 1'b1;

	 force u_top.fake_cpu.wdata = 64'habcdaaaa12345678;
	 force u_top.fake_cpu.wlast = 1'b1;
	 force u_top.fake_cpu.wstrb = 4'hf;
	 force u_top.fake_cpu.wvalid = 1'b1;
	 force u_top.fake_cpu.bready = 1'b1;

	 #40

         // start singals, action1
	 force u_top.fake_cpu.awid = 4'h0;
	 force u_top.fake_cpu.awsize = 3'h2;
         force u_top.fake_cpu.awaddr = 32'h100;
         force u_top.fake_cpu.awvalid = 1'b1;

         force u_top.fake_cpu.wdata = 64'haaaabbbbccccdddd;
         force u_top.fake_cpu.wlast = 1'b1;
	 force u_top.fake_cpu.wstrb = 4'hf;
         force u_top.fake_cpu.wvalid = 1'b1;
         force u_top.fake_cpu.bready = 1'b1;
      end

   always #5 clk=~clk;
   

   top u_top (
      .clk      (clk      ),
      .resetn   (resetn   )
      );

      always @(posedge clk)
      begin
	      $display("+");
	      //$display("reset %b", resetn);


	      // end signals s0
	      if (u_top.fake_cpu.awready === 1'b1 && u_top.fake_cpu.awvalid === 1'b1)
	      begin
		      force u_top.fake_cpu.awaddr = 32'h0;
		      force u_top.fake_cpu.awvalid = 1'b0;
	      end
	      if (u_top.fake_cpu.wready === 1'b1 && u_top.fake_cpu.wvalid === 1'b1)
	      begin
		      force u_top.fake_cpu.wdata = 32'h00000000;
		      force u_top.fake_cpu.wlast = 1'b0;
		      force u_top.fake_cpu.wvalid = 1'b0;
	      end

	      // end a signal s1
	      if (u_top.fake_cpu.bvalid === 1'b1)
	      begin
		      //force u_top.fake_cpu.bready = 1'b0;
	      end


      end
   
endmodule // top_tb
