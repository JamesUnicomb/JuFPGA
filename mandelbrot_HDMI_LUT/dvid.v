`timescale 1ns / 1ps


module dvid (
  input clk,
  input clk_n,
  input clk_pixel,
  input rst,

  input [7:0] red_p,
  input [7:0] green_p,
  input [7:0] blue_p,

  input blank,
  input de,
  input hsync,
  input vsync,

  output red_s,
  output green_s,
  output blue_s,
  output clock_s
);

wire [9:0] encoded_red, encoded_green, encoded_blue;
reg  [9:0] latched_red = 0, latched_green = 0, latched_blue = 0;
reg  [9:0] shift_red = 0, shift_green = 0, shift_blue = 0;
reg  [9:0] shift_clock = 10'b0000011111;

//dvi_encoder dvi_encoder_red   (.clk(clk_pixel), .rst(rst), .c0(0),     .c1(0),     .de(de), .d(red_p),   .q_out(encoded_red));
//dvi_encoder dvi_encoder_green (.clk(clk_pixel), .rst(rst), .c0(0),     .c1(0),     .de(de), .d(green_p), .q_out(encoded_green));
//dvi_encoder dvi_encoder_blue  (.clk(clk_pixel), .rst(rst), .c0(hsync), .c1(vsync), .de(de), .d(blue_p),  .q_out(encoded_blue));

encode dvi_encoder_red   (.clkin(clk_pixel), .rstin(rst), .c0(0),     .c1(0),     .de(de), .din(red_p),   .dout(encoded_red));
encode dvi_encoder_green (.clkin(clk_pixel), .rstin(rst), .c0(0),     .c1(0),     .de(de), .din(green_p), .dout(encoded_green));
encode dvi_encoder_blue  (.clkin(clk_pixel), .rstin(rst), .c0(hsync), .c1(vsync), .de(de), .din(blue_p),  .dout(encoded_blue));


ODDR2 #(.DDR_ALIGNMENT("C0"), .INIT(0), .SRTYPE("ASYNC"))
  ODDR_red(.Q(red_s), .D0(shift_red[0]), .D1(shift_red[1]), .C0(clk), .C1(clk_n), .CE(1), .R(0), .S(0));

ODDR2 #(.DDR_ALIGNMENT("C0"), .INIT(0), .SRTYPE("ASYNC"))
  ODDR_green(.Q(green_s), .D0(shift_green[0]), .D1(shift_green[1]), .C0(clk), .C1(clk_n), .CE(1), .R(0), .S(0));

ODDR2 #(.DDR_ALIGNMENT("C0"), .INIT(0), .SRTYPE("ASYNC"))
  ODDR_blue(.Q(blue_s), .D0(shift_blue[0]), .D1(shift_blue[1]), .C0(clk), .C1(clk_n), .CE(1), .R(0), .S(0));

// ODDR2 #(.DDR_ALIGNMENT("C0"), .INIT(0), .SRTYPE("ASYNC"))
//   ODDR_clock(.Q(clock_s), .D0(shift_clock[0]), .D1(shift_clock[1]), .C0(clk), .C1(clk_n), .CE(1), .R(0), .S(0));

ODDR2 #(.DDR_ALIGNMENT("C0"), .INIT(0), .SRTYPE("ASYNC"))
  ODDR_clock(.Q(clock_s), .D0(1), .D1(0), .C0(clk_pixel), .C1(~clk_pixel), .CE(1), .R(0), .S(0));

always @ ( posedge clk_pixel ) begin
  latched_red   <= encoded_red;
  latched_green <= encoded_green;
  latched_blue  <= encoded_blue;
end

always @ ( posedge clk ) begin
  if (shift_clock == 10'b0000011111) begin
    shift_red   <= latched_red;
    shift_green <= latched_green;
    shift_blue  <= latched_blue;
  end else begin
    shift_red   <= { 2'b00, shift_red[9:2] };
    shift_green <= { 2'b00, shift_green[9:2] };
    shift_blue  <= { 2'b00, shift_blue[9:2] };
  end
  shift_clock <= { shift_clock[1:0], shift_clock[9:2] };
end

endmodule // dvid