`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/03/2021 07:50:44 PM
// Design Name: 
// Module Name: FitBit
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


module FitBit(
    input CLK, rst, start,
    input [1:0] MD,
    output si);
    
wire pulse; 
PulseGenerator generator(CLK, start, MD[1:0], pulse);

wire [3:0]an;
wire [6:0]seg;
sevenseg display(CLK, count[15:0], rst, si, an[3:0], seg[6:0]);

reg [15:0] count = 0; 
always @(posedge pulse)
begin
    if(count < 9999)
        count <= count+1;
    else if(count == 9999)
        count <= 0;
    else //should not happen
        count <= 0;
end

reg [7:0] fixedM = 0;
always @(count)
begin
    if(count < 2048)
        fixedM <= 0;
    else if(2048 <= count < 4096)
        fixedM <= 5;
    else if(4096 <= count < 6144)
        fixedM <= 10;
    else if(6144 <= count < 8192)
        fixedM <= 15;
    else //if count >= 8192
        fixedM <= 20; 
end

endmodule
