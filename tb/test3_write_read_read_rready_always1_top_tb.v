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

	 // init 
	 force u_top.fake_cpu.araddr = 32'h0;
	 force u_top.fake_cpu.arvalid = 1'b0;
	 force u_top.fake_cpu.rready = 1'b0;
	 force u_top.fake_cpu.bready = 1'b0;
	 
	 

	 // start singals, s0
	 force u_top.fake_cpu.awaddr = 32'h4;
	 force u_top.fake_cpu.awvalid = 1'b1;

	 force u_top.fake_cpu.wdata = 64'h12345678;
	 force u_top.fake_cpu.wlast = 1'b1;
	 force u_top.fake_cpu.wvalid = 1'b1;
	 force u_top.fake_cpu.bready = 1'b1;
	 #10
	    
	 #10
	    // start a read, s2
	 force u_top.fake_cpu.araddr = 32'h4;
	 force u_top.fake_cpu.arvalid = 1'b1;
	 force u_top.fake_cpu.rready = 1'b1;

	 #10
	 #10
	    // start a read, s3
	 force u_top.fake_cpu.araddr = 32'h18;
	 force u_top.fake_cpu.arvalid = 1'b1;
	 force u_top.fake_cpu.rready = 1'b1;
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
	       force u_top.fake_cpu.bready = 1'b0;
	    end

	// end a read s2, s3
	 if (1'b1 === u_top.fake_cpu.arready && u_top.fake_cpu.arvalid === 1'b1)
	    begin
	       force u_top.fake_cpu.arvalid = 1'b0;
	    end
	 if (1'b1 === u_top.fake_cpu.rvalid)
	    begin
	       //force u_top.fake_cpu.rready = 1'b0;
	       $display("read out addr 0x%x: 0x%x", u_top.fake_cpu.araddr, u_top.fake_cpu.rdata);
	       //if (64'habcdaaaa12345678 === u_top.fake_cpu.rdata)
	       if (64'haabbccdd === u_top.fake_cpu.rdata)
	       begin
		       $display("\nPASS!\n");
		       $finish;
	       end
	    end
	 
      end
   
endmodule // top_tb
