`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/03/2021 09:09:44 PM
// Design Name: 
// Module Name: 2sDelayModeChange
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


module DelayModeChange();
    reg CLK = 0;
    reg rst = 0; 
    reg start = 0;
    reg [1:0] MD = 0;
    wire si;  
    wire [2:0]outType;
    wire [21:0]delay;
    always #1 CLK = ~CLK;
     
FitBit test(CLK, rst, start, MD[1:0], si, outType[2:0], delay[21:0]);
    initial begin
        MD = 2'b00;
        start = 0;
        #1000
        start = 1;

    end
endmodule
