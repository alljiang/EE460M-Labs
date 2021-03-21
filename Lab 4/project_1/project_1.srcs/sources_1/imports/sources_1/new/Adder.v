`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2021 08:46:15 PM
// Design Name: 
// Module Name: Adder
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

module Adder(
    input clk,
    input btnU, btnD, btnR, btnL,
    input [14:0] regVal,
    output reg[14:0] toDecr
    );
reg [14:0] valBuf; 

always @(posedge clk)
begin
    valBuf = regVal;
    
    if(btnU) begin
        valBuf = valBuf + 10;
        if(valBuf < 9999) begin
            toDecr = valBuf;
        end
        else begin
            toDecr = 9999;
        end
    end
    
    else if(btnD) begin
    valBuf = valBuf + 550;
        if(valBuf < 9999) begin
            toDecr = valBuf;
        end
        else begin
            toDecr = 9999;
        end
    end
    
    else if(btnR) begin
    valBuf = valBuf + 200;
        if(valBuf < 9999) begin
            toDecr = valBuf;
        end
        else begin
            toDecr = 9999;
        end
    end
    
    else if(btnL) begin
    valBuf = valBuf + 180;
        if(valBuf < 9999) begin
            toDecr = valBuf;
        end
        else begin
            toDecr = 9999;
        end
    end
    else begin
        toDecr = valBuf;
    end
end
    
endmodule
