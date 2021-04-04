`timescale 1ns / 1ps

module tb_controller();

reg clk = 0;
reg [3:0] btns = 0;
reg [7:0] swtchs = 0;
wire[7:0] leds;
wire[6:0] segs;
wire[3:0] an;

always #1 clk = ~clk;

top toppp(clk, btns, swtchs, leds, segs, an);

initial begin
    btns = 4'b0000;
    #10;
    swtchs = 8;
    btns = 4'b0001;
    #20;
    btns = 4'b0000;
    #20;
    swtchs = 3;
    #1;
    btns = 4'b0001;
    #20;
    btns = 4'b0000;
    #20;
    btns = 4'b0101;
    #20;
    btns = 4'b0000;
    
end

endmodule
