`timescale 1ns / 1ps

module TB_Fitbit();

reg CLK = 0;
reg rst = 0;
reg start = 0;
reg[1:0] mode;
wire si;
wire [3:0] an;
wire [6:0] seg;
wire dp;

always #(5*10000) CLK = ~CLK;

FitBit fb(
    CLK, rst, start,
    mode,
    si,
    an,
    seg,
    dp
);

initial begin

    rst = 0;
    start = 1;
    mode = 2'b11;
    #2000000000;
    #2000000000;
    #2000000000;
    #2000000000;
    #2000000000;
    #2000000000;

end

endmodule
