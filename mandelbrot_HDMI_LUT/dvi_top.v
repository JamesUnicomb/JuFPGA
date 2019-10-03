`timescale 1ns / 1ps


module dvi_top (
  input clk_pix_1x,
  input clk_pix_5x,
  input clk_pix_5x_180,

  input rst,

  input [7:0] red,
  input [7:0] blue,
  input [7:0] green,
  input de,
  input blank,
  input hsync,
  input vsync,

  output [3:0] tmds,
  output [3:0] tmdsb
  
);

wire [7:0] red, blue, green;

OBUFDS OBUFDS_blue  (.O(tmds[0]), .OB(tmdsb[0]), .I(blue_s));
OBUFDS OBUFDS_green (.O(tmds[1]), .OB(tmdsb[1]), .I(green_s));
OBUFDS OBUFDS_red   (.O(tmds[2]), .OB(tmdsb[2]), .I(red_s));
OBUFDS OBUFDS_clock (.O(tmds[3]), .OB(tmdsb[3]), .I(clock_s));

dvid dvid (
  .clk       (clk_pix_5x),
  .clk_n     (clk_pix_5x_180),
  .clk_pixel (clk_pix_1x),
  .rst       (rst),

  // input rgb data
  .red_p     (red),
  .green_p   (green),
  .blue_p    (blue),

  // vga timing signals
  .de        (de),
  .blank     (blank),
  .hsync     (hsync),
  .vsync     (vsync),

  // serialized data ready for differential output buffer
  .red_s     (red_s),
  .green_s   (green_s),
  .blue_s    (blue_s),

  // Forwarded clock for differential output buffer
  .clock_s   (clock_s)
);




endmodule // dvi