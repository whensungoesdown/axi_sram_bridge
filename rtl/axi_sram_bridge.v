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

endmodule // soc_axi_sram_bridge

   
