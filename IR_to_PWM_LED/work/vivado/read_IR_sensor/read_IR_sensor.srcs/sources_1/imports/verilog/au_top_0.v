// Name: XADC_read_MUX
// Author: Prof. Eric Prebys, UC Davis
// Tools: Alchitry Labs 1.0.6, Vivado 2018.3
//
// Description:
// ------------
// This is a simple example of how to use the XADC to continuously read out and 
// display one of the internally multilexed channels or the dedicated analog input
// using the Alchitry Au FPGA board and Alchitry Io I/O board.  
// Inputs:
//   io_dip[4:0] - select which channel is displayed, according to the table 3-1 of
//                 the XADC User guide. Example:  
//                     Channel 0-> temperature
//                     Channel 3-> Analog input
//   io_dip[7]   - display mode:
//                     0:  All 16 bits are displayed in HEX
//                     1:  12 MSBs displayed in decimal
// Outputs:
//   led[7:0]    - echo io_dip settings
//   io_led[15:0]- binary display of 16 bit ADC register
//   io_sel, io_seg - display of ADC register in HEX or BCD, depending
//                    on io_dip[7] state
//
// The xadc_wiz_0.v file was generated using the XADC wizard in Vivado, as described in 
// this video: https://www.youtube.com/watch?v=eAwTEMPUUCg with the following settings
//  
//   - The RESET bit and alarms were all turned off, 
//   - "channel sequencer" was enabled, 
//   - all the channels except for the auxiliary inputs were selected. 
//   - The analog input is set to unipolar operation (12 bits, 0-1V) 
// Everything else was left default (DRP interface).  
// The xadc_wiz_0.v file was then imported from from: 
// (Vivado project_dir)/(project_name).srcs/sources_1/ip/xadc_wiz_0/
//
//
// Version History
//   1.0  - 20190405:  Original
//   1.1  - 20190423:  Added DEC display.  Added some tweaks.
// 
module au_top_0(
    input clk,              // 100MHz clock
    input rst_n,              // reset button
    input vp_in,            // Dedicated analog input(+) 
    input vn_in,            // Dedicated analong input(-)
    output [7:0] led       // Use Au LEDs for debug output
   );
   
    wire rst = ~rst_n; // make reset active high
   
    wire enable;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              wire [6:0] channel;
    wire [15:0] XADC_out;
    reg [15:0] XADC_bytes;
    wire drdy;

    assign channel={8'b00000011};
    //assign led=XADC_out[15:8];
    
    genvar i;
    generate
      for (i = 0; i < 8; i=i+1) begin: pwm_gen_loop
      pwm_1 #(.CTR_LEN(8)) pwm (
        .clk(clk),
        .rst(rst),
        .compare(XADC_out[15:8]),
        .pwm(led[i])
      );
      end
    endgenerate

    xadc_wiz_0_2 xadc_wiz_0
          (.daddr_in(channel),
           .dclk_in(clk),             // Clock input for the dynamic reconfiguration port
           .den_in(enable),           // Data enable
           .di_in(0),
           .dwe_in(0),                // Write enable
           .busy_out(),               // ADC Busy signal
           .channel_out(),            // Channel Selection Outputs
           .do_out(XADC_out),         // Data out
           .drdy_out(drdy),           // Data ready
           .eoc_out(enable),          // End of Conversion Signal
           .eos_out(),                // End of Sequence Signal
           .alarm_out(),              // OR'ed output of all the Alarms    
           .vp_in(vp_in),             // Dedicated Analog Input Pair
           .vn_in(vn_in));   
  
    always @(posedge clk) if(drdy==1) XADC_bytes=XADC_out;  // I don't strictly speaking know 
                                                            // if this line is necessary
  
endmodule