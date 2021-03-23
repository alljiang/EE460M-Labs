`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2021 06:10:38 PM
// Design Name: 
// Module Name: TB_adder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TB_adder();

    reg clk = 0;
    reg btnU = 0;
    reg btnD = 0; 
    reg btnR = 0;
    reg btnL = 0;
    reg [14:0] regVal;
    wire [14:0] toDecr;
    
    wire flash2s;
    wire flash1s;

always #1 clk = ~clk;

Adder add(clk, btnU, btnD, btnR, btnL, regVal, toDecr);
Decrementer D(clk, toDecr, regVal, flash2s, flash1s);

initial begin
    regVal = 9000;
    #10
    btnU = 1;
    //regVal should = 9010
    regVal = toDecr;
    #10
    btnU = 0;
    btnL = 1;
    regVal = toDecr;
    //regval should = 9190
    #10
    btnL = 0;
    btnR = 1;
    regVal = toDecr;
    //regVal should = 9390
    #10
    btnR = 0;
    btnD = 1;
    regVal = toDecr;
    //regVal should = 9390+550 = 9940
    #10
    btnD = 0;
    btnR = 1;
    regVal = toDecr;
    //regVal should overflow and stay 9999
    #10
    btnR = 0;
    btnU = 1;
    regVal = toDecr;
    //regval should stay 9999
end


endmodule
