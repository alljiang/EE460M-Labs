`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/10/2021 04:47:34 PM
// Design Name: 
// Module Name: Main
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


module Main(
    input CLK, rst, start,
    input [1:0] MD,
    output si);
    
PulseGenerator generator(CLK, start, MD, pulse);
FitBit Pt1_2(CLK, rst, start, MD, pulse, si);
    
endmodule
