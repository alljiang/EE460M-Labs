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
PulseGenerator(
CLK,
 start,
 [1:0]MD,
 pulse
);

wire [3:0]an;
wire [6:0]seg;
module sevenseg(
CLK, [15:0]count, rst, si, [3:0]an, [6:0]seg);


reg [15:0] count; 
always @(posedge pulse)
begin
    if(count < 9999)
        count <= count+1;
    else if(count = 9999)
        count <= 0;
    else //should not happen
        count <= 0;
end

endmodule
