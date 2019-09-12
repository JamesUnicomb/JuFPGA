module au_top_0 (
    input clk,
    input rst_n,
    output reg [7:0] led,
    input usb_rx,
    output reg usb_tx,
    output reg [23:0] io_led,
    output reg [7:0] io_seg,
    output reg [3:0] io_sel,
    input [4:0] io_button,
    input [23:0] io_dip
  );
  
  
  
  reg rst;
  
  wire [1-1:0] M_reset_cond_out;
  reg [1-1:0] M_reset_cond_in;
  reset_conditioner_1 reset_cond (
    .clk(clk),
    .in(M_reset_cond_in),
    .out(M_reset_cond_out)
  );
  
  reg [119:0] result;
  
  reg [23:0] result_out;
  
  wire [3-1:0] M_enc_out;
  reg [5-1:0] M_enc_in;
  encoder_2 enc (
    .in(M_enc_in),
    .out(M_enc_out)
  );
  
  always @* begin
    M_reset_cond_in = ~rst_n;
    rst = M_reset_cond_out;
    usb_tx = usb_rx;
    led = 8'h00;
    io_led = 24'h000000;
    io_seg = 8'hff;
    io_sel = 4'hf;
    result[24+0+8-:9] = io_dip[0+7-:8];
    result[24+8+8-:9] = io_dip[8+7-:8];
    M_enc_in = io_button;
    result[48+23-:24] = io_dip[0+7-:8] + io_dip[8+7-:8];
    result[72+23-:24] = io_dip[0+7-:8] - io_dip[8+7-:8];
    result[96+23-:24] = io_dip[0+7-:8] * io_dip[8+7-:8];
    result_out = result[(M_enc_out)*24+23-:24];
    io_led = {result_out[16+7-:8], result_out[8+7-:8], result_out[0+7-:8]};
  end
endmodule
