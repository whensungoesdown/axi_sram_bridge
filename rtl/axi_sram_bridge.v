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


    input  wire [`Laraddr -1 :0]     m_araddr ,
    input  wire [`Larburst-1 :0]     m_arburst,
    input  wire [`Larcache-1 :0]     m_arcache,
    input  wire [`Larid   -1 :0]     m_arid   ,
    input  wire [`Larlen  -1 :0]     m_arlen  ,
    input  wire [`Larlock -1 :0]     m_arlock ,
    input  wire [`Larprot -1 :0]     m_arprot ,
    output wire                      m_arready,
    input  wire [`Larsize -1 :0]     m_arsize ,
    input  wire                      m_arvalid,

    output wire [`Lrdata  -1 :0]     m_rdata  ,
    output wire [`Lrid    -1 :0]     m_rid    ,
    output wire                      m_rlast  ,
    input  wire                      m_rready ,
    output wire [`Lrresp  -1 :0]     m_rresp  ,
    output wire                      m_rvalid ,
   
    input  wire [`Lawaddr -1 :0]     m_awaddr ,
    input  wire [`Lawburst-1 :0]     m_awburst,
    input  wire [`Lawcache-1 :0]     m_awcache,
    input  wire [`Lawid   -1 :0]     m_awid   ,
    input  wire [`Lawlen  -1 :0]     m_awlen  ,
    input  wire [`Lawlock -1 :0]     m_awlock ,
    input  wire [`Lawprot -1 :0]     m_awprot ,
    output wire                      m_awready,
    input  wire [`Lawsize -1 :0]     m_awsize ,
    input  wire                      m_awvalid,

    input  wire [`Lwdata  -1 :0]     m_wdata  ,
    input  wire [`Lwid    -1 :0]     m_wid    ,
    input  wire                      m_wlast  ,
    output wire                      m_wready ,
    input  wire [`Lwstrb  -1 :0]     m_wstrb  ,
    input  wire                      m_wvalid ,
 
    output wire [`Lbid    -1 :0]     m_bid    ,
    input  wire                      m_bready ,
    output wire [`Lbresp  -1 :0]     m_bresp  ,
    output wire                      m_bvalid 
);

   wire ar_enter;
   wire r_retire;

   wire aw_enter;
   wire w_enter;
   wire b_retire;
   
   wire busy;

   wire rdata_valid_tmp;
   wire rdata_valid;
   wire rdata_valid_next;
   //wire [`Lrdata - 1 :0] rdata;

   assign ar_enter = m_arvalid & m_arready;
   assign r_retire = m_rvalid & m_rready & m_rlast;
   //
   // busy means that rready haven't come yet, so the sram
   // cannot accept new read, hence ar_ready should stay 0.
   //
   //  ar_enter      r_retire       busy
   //     0              0           0
   //     1              0           1
   //     0              1           0
   //     1              1           0   (should not happen)


//   dffrle_s #(1) busy_reg (
//      .din   (ar_enter & (~r_retire)),
//      .clk   (aclk),
//      .rst_l (aresetn),
//      .en    (ar_enter | r_retire),
//      .q     (busy), 
//      .se(), .si(), .so());

   wire busy_din;
   wire busy_en;

   assign busy_din = (ar_enter & (~r_retire)) | ((aw_enter | w_enter) & (~b_retire));
   assign busy_en = ar_enter | r_retire | aw_enter | w_enter | b_retire;
   
   dffrle_s #(1) busy_reg (
      .din   (busy_din),
      .clk   (aclk),
      .rst_l (aresetn),
      .en    (busy_en),
      .q     (busy), 
      .se(), .si(), .so());

   assign m_arready = ~busy;

   //
   // If the ar_enter (address send in) in previous cycle,
   // then data ready in this cycle  
   //
   // Need to change logic if the sram's delay is not 1 cycle
   //
//   dff_s #(1) rdata_valid_reg (
//      .din (ar_enter),
//      .clk (aclk),
//      .q   (rdata_valid),    // rdata_valid on the next cycle
//      .se(), .si(), .so());
   
   //wire rdata_valid_next;
   //wire rready;
   //
   //dff_s #(1) rready_reg (
   //   .din   (m_rready),
   //   .clk   (aclk),
   //   .q     (rready), 
   //   .se(), .si(), .so());

   assign rdata_valid_next = (rdata_valid_tmp | ar_enter) & (~m_rready);
   //assign rdata_valid_next = (rdata_valid | ar_enter) & (~rready);
   
   dffrl_s #(1) rdata_valid_reg (
      .din   (rdata_valid_next),
      .clk   (aclk),
      .rst_l (aresetn),
      .q     (rdata_valid_tmp),
      .se(), .si(), .so());

   
   wire ar_enter_delay1;

   dffrl_s #(1) ar_enter_delay1_reg (
      .din   (ar_enter),
      .clk   (aclk),
      .rst_l (aresetn),
      .q     (ar_enter_delay1), 
      .se(), .si(), .so());
   
   // rdata_valid show up at lease one cycle
   assign rdata_valid = rdata_valid_tmp | ar_enter_delay1;

   assign ram_raddr = m_araddr;
   //assign m_arready = 1'b1;  // single cycle ram, always ready
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
   //assign m_rvalid = busy; 



   //
   //  AW W B
   //

   wire aw_busy;
   wire w_busy;
   
   assign aw_enter = m_awvalid & m_awready;
   assign w_enter = m_wvalid & m_wready;
   assign b_retire = m_bvalid & m_bready; // & m_wlast register 

   dffrle_s #(1) aw_busy_reg (
      .din   (aw_enter),
      .clk   (aclk),
      .rst_l (aresetn),
      .en    (aw_enter | b_retire),
      .q     (aw_busy), 
      .se(), .si(), .so());

   assign m_awready = ~aw_busy;

   dffe_s #(`Lawaddr) awaddr_reg (
      .din   (m_awaddr),
      .clk   (aclk),
      .en    (aw_enter),
      .q     (ram_waddr), 
      .se(), .si(), .so());
   
   
   dffrle_s #(1) w_busy_reg (
      .din   (w_enter),
      .clk   (aclk),
      .rst_l (aresetn),
      .en    (w_enter | b_retire),
      .q     (w_busy), 
      .se(), .si(), .so());

   assign m_wready = ~w_busy;
   
   dffe_s #(`Lwdata) wdata_reg (
      .din   (m_wdata),
      .clk   (aclk),
      .en    (w_enter),
      .q     (ram_wdata), 
      .se(), .si(), .so());


   // enable ram write when both awaddr and wdata are received.
   assign ram_wen = aw_busy & w_busy;


   wire bresp_valid;
   wire bresp_valid_tmp;
   wire bresp_valid_next;
   wire bresp_valid_start;
   wire bresp_valid_end;

//   wire bready_delay1;
//   wire bready_delay2;
//
//   
//   dffrl_s #(1) bready1_reg (
//      .din   (m_bready),
//      .clk   (aclk),
//      .rst_l (aresetn),
//      .q     (bready_delay1),
//      .se(), .si(), .so());
//
//   dffrl_s #(1) bready2_reg (
//      .din   (bready_delay1),
//      .clk   (aclk),
//      .rst_l (aresetn),
//      .q     (bready_delay2),     //uty: bug  bready_delay2 bring x
//      .se(), .si(), .so());
   
   assign bresp_valid_start = aw_busy & w_busy;
   assign bresp_valid_end   = m_bready;
   assign bresp_valid_next = (bresp_valid_tmp | bresp_valid_start) & (~bresp_valid_end);
   
   dffrl_s #(1) bresp_valid_reg (
      .din   (bresp_valid_next),
      .clk   (aclk),
      .rst_l (aresetn),
      .q     (bresp_valid_tmp),
      .se(), .si(), .so());

   assign bresp_valid = bresp_valid_tmp | bresp_valid_start;
   
   assign m_bid = `Lbid'b0;
   assign m_bresp = `Lbresp'b0;
   assign m_bvalid = bresp_valid;
   
endmodule // soc_axi_sram_bridge

   
