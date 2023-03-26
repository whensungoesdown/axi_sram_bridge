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

   //wire axi_rd_req;
   //wire axi_rd_ret;

//   assign rready = 1'b1;
   
   //assign axi_rd_req = arvalid && arready;
   //assign axi_rd_ret = rvalid && rlast && rready;// && (rid[3:1]==3'b000);

   
endmodule // cpu
