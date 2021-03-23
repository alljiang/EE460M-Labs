`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2021 08:46:15 PM
// Design Name: 
// Module Name: Decrementer 
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
`define DELAY1s (1000000000) //one second delay
`define DELAY2s (2000000000) //2 second delay

module clkDiv(
    input clk, 
    output reg slowClk
    );
    
reg [31:0]clkBuf = 0;

//delay for slowClk period 
always @(posedge clk) 
begin
    if(clkBuf < `DELAY1s -1)
        clkBuf = clkBuf + 1;
    else begin
        clkBuf = 0;
        slowClk = ~slowClk;
    end
end
endmodule



module Decrementer(
    input clk,
    input [14:0]valReg,
    output reg[14:0] postVal,
    output reg flash2s = 0,
    output reg flash1s = 0
    );

reg gethere = 0;
always @(posedge clk)
begin
    if(valReg > 200)begin
        postVal = valReg - 1;
        flash2s = 0;
        flash1s = 0;
    end
    
    //flash with period 2s
    else if ((1 <= valReg ) && (valReg <= 200)) begin
        postVal = valReg - 1;
        flash2s = 1;
        flash1s = 0;
    end
    
    //flash 0000 with period 1s
    else begin
        gethere = 1;
        postVal = 0;
        flash1s = 1;
        flash2s = 0;
    end 
end

endmodule