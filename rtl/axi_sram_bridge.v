`include "defines.vh"

module axi_sram_bridge(
    input  wire                      aclk     ,
    input  wire                      aresetn  ,

    output wire [`BUS_WIDTH-1    :0] ram_raddr,
    input  wire [`DATA_WIDTH-1   :0] ram_rdata,
    output wire                      ram_ren  ,
    output wire [`BUS_WIDTH-1    :0] ram_waddr,
    output wire [`DATA_WIDTH-1   :0] ram_wdata,
    output wire [`DATA_WIDTH/8-1 :0] ram_wen  ,

    input  wire [`Laraddr     -1 :0] m_araddr ,
    input  wire [`Larburst    -1 :0] m_arburst,
    input  wire [`Larcache    -1 :0] m_arcache,
    input  wire [`Larid       -1 :0] m_arid   ,
    input  wire [`Larlen      -1 :0] m_arlen  ,
    input  wire [`Larlock     -1 :0] m_arlock ,
    input  wire [`Larprot     -1 :0] m_arprot ,
    output wire                      m_arready,
    input  wire [`Larsize     -1 :0] m_arsize ,
    input  wire                      m_arvalid,

    output wire [`Lrdata      -1 :0] m_rdata  ,
    output wire [`Lrid        -1 :0] m_rid    ,
    output wire                      m_rlast  ,
    input  wire                      m_rready ,
    output wire [`Lrresp      -1 :0] m_rresp  ,
    output wire                      m_rvalid ,

       
    input  wire [`Lawaddr     -1 :0] m_awaddr ,
    input  wire [`Lawburst    -1 :0] m_awburst,
    input  wire [`Lawcache    -1 :0] m_awcache,
    input  wire [`Lawid       -1 :0] m_awid   ,
    input  wire [`Lawlen      -1 :0] m_awlen  ,
    input  wire [`Lawlock     -1 :0] m_awlock ,
    input  wire [`Lawprot     -1 :0] m_awprot ,
    output wire                      m_awready,
    input  wire [`Lawsize     -1 :0] m_awsize ,
    input  wire                      m_awvalid,

    output wire [`Lbid        -1 :0] m_bid    ,
    input  wire                      m_bready ,
    output wire [`Lbresp      -1 :0] m_bresp  ,
    output wire                      m_bvalid ,

    input  wire [`Lwdata      -1 :0] m_wdata  ,
    input  wire [`Lwid        -1 :0] m_wid    ,
    input  wire                      m_wlast  ,
    output wire                      m_wready ,
    input  wire [`Lwstrb      -1 :0] m_wstrb  ,
    input  wire                      m_wvalid 
);

   wire ar_enter;
   //wire r_retire;
   //wire busy;

   wire rdata_valid;
   //wire [`Lrdata - 1 :0] rdata;

   assign ar_enter = m_arvalid & m_arready;
   //assign r_retire = m_rvalid & m_rready & m_rlast;
   // not sure about the busy signal
   //  ar_enter     ar_retire       busy
   //     0              0           0
   //     1              0           1
   //     0              1           0
   //     1              1           1



   //
   // If the ar_enter (address send in) in previous cycle,
   // then data ready in this cycle  
   //
   // Need to change logic if the sram's delay is not 1 cycle
   //
   dff_s #(1) rdata_valid_reg (
      .din (ar_enter),
      .clk (aclk),
      .q   (rdata_valid),    // rdata_valid on the next cycle
      .se(), .si(), .so());
   


   assign ram_raddr = m_araddr;
   assign m_arready = 1'b1;  // single cycle ram, always ready
   assign ram_ren = ar_enter;

   
//   dff_s #(`Lrdata) rdata_reg (
//      .din (ram_rdata),
//      .clk (aclk),
//      .q   (rdata),
//      .se(), .si(), .so());
   
   assign m_rid = `Lrid'b0;
   assign m_rlast = 1'b1;
   assign m_rresp = `Lrresp'b0; // optional
   assign m_rdata = ram_rdata;
   assign m_rvalid = rdata_valid;

endmodule // soc_axi_sram_bridge

   
