`include "../../rtl/defines.vh"

module top(
   input  clk,
   input  resetn
   );

   wire [`Lawid       -1 :0] cpu_awid;
   wire [`Lawaddr     -1 :0] cpu_awaddr;
   wire [`Lawlen      -1 :0] cpu_awlen;
   wire [`Lawsize     -1 :0] cpu_awsize;
   wire [`Lawburst    -1 :0] cpu_awburst;
   wire [`Lawlock     -1 :0] cpu_awlock;
   wire [`Lawcache    -1 :0] cpu_awcache;
   wire [`Lawprot     -1 :0] cpu_awprot;
   wire                      cpu_awvalid;
   wire                      cpu_awready;
   wire [`Lwid        -1 :0] cpu_wid;
   wire [`Lwdata      -1 :0] cpu_wdata;
   wire [`Lwstrb      -1 :0] cpu_wstrb;
   wire                      cpu_wlast;
   wire                      cpu_wvalid;
   wire                      cpu_wready;
   wire [`Lbid        -1 :0] cpu_bid;
   wire [`Lbresp      -1 :0] cpu_bresp;
   wire                      cpu_bvalid;
   wire                      cpu_bready;
   
   wire [`Larid       -1 :0] cpu_arid;
   wire [`Laraddr     -1 :0] cpu_araddr;
   wire [`Larlen      -1 :0] cpu_arlen;
   wire [`Larsize     -1 :0] cpu_arsize;
   wire [`Larburst    -1 :0] cpu_arburst;
   wire [`Larlock     -1 :0] cpu_arlock;
   wire [`Larcache    -1 :0] cpu_arcache;
   wire [`Larprot     -1 :0] cpu_arprot;
   wire                      cpu_arvalid;
   wire                      cpu_arready;
   wire [`Lrid        -1 :0] cpu_rid;
   wire [`Lrdata      -1 :0] cpu_rdata;
   wire [`Lrresp      -1 :0] cpu_rresp;
   wire                      cpu_rlast;
   wire                      cpu_rvalid;
   wire                      cpu_rready;

   //ram
   wire [`BUS_WIDTH -1:0]    ram_raddr;
   wire [`DATA_WIDTH-1:0]    ram_rdata;
   wire                      ram_ren  ;
   wire [`BUS_WIDTH -1:0]    ram_waddr;
   wire [`DATA_WIDTH-1:0]    ram_wdata;
   wire [`DATA_WIDTH/8-1:0]  ram_wen;


   

   cpu fake_cpu(
      .clk          (clk             ),
      .resetn       (resetn          ),
      
      .arid         (cpu_arid        ),
      .araddr       (cpu_araddr      ),
      .arlen        (cpu_arlen       ),
      .arsize       (cpu_arsize      ),
      .arburst      (cpu_arburst     ),
      .arlock       (cpu_arlock      ),
      .arcache      (cpu_arcache     ),
      .arprot       (cpu_arprot      ),
      .arvalid      (cpu_arvalid     ),
      .arready      (cpu_arready     ),

      .rid          (cpu_rid         ),
      .rdata        (cpu_rdata       ),
      .rresp        (cpu_rresp       ),
      .rlast        (cpu_rlast       ),
      .rvalid       (cpu_rvalid      ),
      .rready       (cpu_rready      )
);

   

   axi_sram_bridge u_axi_sram_bridge(
      .aclk         (clk             ),
      .aresetn      (resetn          ),

      .ram_raddr    (ram_raddr       ),
      .ram_rdata    (ram_rdata       ),
      .ram_ren      (ram_ren         ),
      .ram_waddr    (ram_waddr       ),
      .ram_wdata    (ram_wdata       ),
      .ram_wen      (ram_wen         ),

      .m_araddr     (cpu_araddr      ),
      .m_arburst    (cpu_arburst     ),
      .m_arcache    (cpu_arcache     ),
      .m_arid       (cpu_arid        ),
      .m_arlen      (cpu_arlen       ),
      .m_arlock     (cpu_arlock      ),
      .m_arprot     (cpu_arprot      ),
      .m_arready    (cpu_arready     ),
      .m_arsize     (cpu_arsize      ),
      .m_arvalid    (cpu_arvalid     ),

      .m_rdata      (cpu_rdata       ),
      .m_rid        (cpu_rid         ),
      .m_rlast      (cpu_rlast       ),
      .m_rready     (cpu_rready      ),
      .m_rresp      (cpu_rresp       ),
      .m_rvalid     (cpu_rvalid      )
 
      );


   
   sram ram(
      .clock        (clk             ),
      .rdaddress    (ram_raddr[14:2] ),
      .q            (ram_rdata       ),
      .rden         (ram_ren         ),
      .wraddress    (ram_waddr[14:2] ),
      .data         (ram_wdata       ),
      .wren         (|ram_wen        )
      );

   
endmodule // top
