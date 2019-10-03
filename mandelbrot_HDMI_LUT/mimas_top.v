`timescale 1ns / 1ps

module mimas_top(
        input clk_100mhz,   // 100 MHz
        input reset,        // reset signal
        input [7:0] dip_sw, // switches
        output [7:0] led,   // leds
        output [3:0] tmds,  // HDMI TMDS pos
        output [3:0] tmdsb  // HDMI TMDS neg
    );
    
    assign led = dip_sw;
    
    wire clk_pix_1x, clk_pix_5x, clk_pix_5x_180;
    clk_wiz_0 clk_wiz (.clk_in(clk_100mhz), 
                       .reset(reset), 
                       .clk_out_25mhz(clk_pix_1x),
                       .clk_out_125mhz(clk_pix_5x),
                       .clk_out_125mhz_180p(clk_pix_5x_180));
                       
    reg [9:0] CounterX;  // counts from 0 to 799
    always @(posedge clk_pix_1x) CounterX <= (CounterX==799) ? 0 : CounterX+1;
    
    reg [9:0] CounterY;  // counts from 0 to 524
    always @(posedge clk_pix_1x) if(CounterX==799) CounterY <= (CounterY==524) ? 0 : CounterY+1;
    
    wire hsync = (CounterX>=656) && (CounterX<752);
    wire vsync = (CounterY>=490) && (CounterY<492);
    wire de    = (CounterX<640) && (CounterY<480);
    wire blank = ~de;
    
    wire [7:0] rgbk;
    mandelbrot_lut mandelbrot_lut (.i(CounterX), .j(CounterY), .m(rgbk));
    
    wire [7:0] red   = rgbk;
    wire [7:0] green = rgbk;
    wire [7:0] blue  = rgbk;
    
    dvi_top dvi_top (.clk_pix_1x(clk_pix_1x),
                          .clk_pix_5x(clk_pix_5x),
                          .clk_pix_5x_180(clk_pix_5x_180),
                          .rst(reset),
                          .red(red),
                          .blue(blue),
                          .green(green),
                          .de(de),
                          .blank(blank),
                          .hsync(hsync),
                          .vsync(vsync),
                          .tmds(tmds),
                          .tmdsb(tmdsb));
    
endmodule
