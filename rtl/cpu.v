`include "defines.vh"

module cpu(
   input                        clk    ,
   input                        resetn ,
   //  axi_control
   //ar
   output [`Larid   -1 :0]      arid   ,
   output [`Laraddr -1 :0]      araddr ,
   output [`Larlen  -1 :0]      arlen  ,
   output [`Larsize -1 :0]      arsize ,
   output [`Larburst-1 :0]      arburst,
   output [`Larlock -1 :0]      arlock ,
   output [`Larcache-1 :0]      arcache,
   output [`Larprot -1 :0]      arprot ,
   output                       arvalid,
   input                        arready,
   //r
   input  [`Lrid    -1 :0]      rid    ,
   input  [`Lrdata  -1 :0]      rdata  ,
   input  [`Lrresp  -1 :0]      rresp  ,
   input                        rlast  ,
   input                        rvalid ,
   output                       rready ,

   //aw
   output [`Lawid   -1 :0]      awid   ,
   output [`Lawaddr -1 :0]      awaddr ,
   output [`Lawlen  -1 :0]      awlen  ,
   output [`Lawsize -1 :0]      awsize ,
   output [`Lawburst-1 :0]      awburst,
   output [`Lawlock -1 :0]      awlock ,
   output [`Lawcache-1 :0]      awcache,
   output [`Lawprot -1 :0]      awprot ,
   output                       awvalid,
   input                        awready,
   //w
   output [`Lwid    -1 :0]      wid    ,
   output [`Lwdata  -1 :0]      wdata  ,
   output [`Lwstrb  -1 :0]      wstrb  ,
   output                       wlast  ,
   output                       wvalid ,
   input                        wready ,
   //b
   input  [`Lbid    -1 :0]      bid    ,
   input  [`Lbresp  -1 :0]      bresp  ,
   input                        bvalid ,
   output                       bready
   );

   wire axi_rd_req;
   wire axi_rd_ret;

//   assign rready = 1'b1;
   
   assign axi_rd_req = arvalid && arready;
   assign axi_rd_ret = rvalid && rlast && rready;// && (rid[3:1]==3'b000);


   wire          inst_req;
   wire [31:0]   inst_addr;
   wire [31:0]   inst_rdata;
   wire          inst_valid;

   wire [31:0]   inst_addr_nxt;

   assign inst_req = resetn; // always high after reset
  
   dffrle_s #(32) inst_addr_reg (
      .din   (inst_addr_nxt),
      .clk   (clk),
      .en    (inst_valid),
      .rst_l (resetn),
      .q     (inst_addr), 
      .se(), .si(), .so());
   
   //assign inst_addr = 31'h10;
   assign inst_addr_nxt = inst_addr + 32'h4;
   
   
   axi_interface u_axi_interface(
      .aclk        (clk        ),
      .aresetn     (resetn     ), 


      .arid	   (arid       ),
      .araddr	   (araddr     ),
      .arlen	   (arlen      ),
      .arsize	   (arsize     ),
      .arburst	   (arburst    ),
      .arlock	   (arlock     ),
      .arcache	   (arcache    ),
      .arprot	   (arprot     ),
      .arvalid	   (arvalid    ),
      .arready	   (arready    ),

      .rid	   (rid        ),
      .rdata	   (rdata      ),
      .rresp	   (rresp      ),
      .rlast	   (rlast      ),
      .rvalid	   (rvalid     ),
      .rready	   (rready     ),


      .awid	   (awid       ),
      .awaddr	   (awaddr     ),
      .awlen	   (awlen      ),
      .awsize	   (awsize     ),
      .awburst	   (awburst    ),
      .awlock	   (awlock     ),
      .awcache	   (awcache    ),
      .awprot	   (awprot     ),
      .awvalid	   (awvalid    ),
      .awready	   (awready    ),

      .wid	   (wid        ),
      .wdata	   (wdata      ),
      .wstrb	   (wstrb      ),
      .wlast	   (wlast      ),
      .wvalid	   (wvalid     ),
      .wready	   (wready     ),

      .bid	   (bid        ),
      .bresp	   (bresp      ),
      .bvalid	   (bvalid     ),
      .bready	   (bready     ),

      .inst_req    (inst_req   ),
      .inst_addr   (inst_addr  ),
      .inst_valid  (inst_valid ),
      .inst_rdata  (inst_rdata )
      );
   
endmodule // cpu
