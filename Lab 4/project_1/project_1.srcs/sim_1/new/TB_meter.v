`timescale 1ns / 1ps

module TB_meter();

reg clk = 0;
reg btnU, btnL, btnR, btnD;
reg [1:0] sw;
wire [6:0] seg;
wire [3:0] anode;

Meter m(
    clk,
    btnU, btnL, btnR, btnD,
    sw,
    seg, anode
);

always #(5*100000) clk = ~clk;

initial begin

    btnU = 0;   //  10
    btnL = 0;   //  180
    btnR = 0;   //  200
    btnD = 0;   //  550
    sw[0] = 0;  //  set to 10
    sw[1] = 0;  //  set to 205
    
    btnU = 1;
    #1000;
    btnU = 0;

end

endmodule
