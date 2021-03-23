`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/23/2021 03:43:11 PM
// Design Name: 
// Module Name: TB_decrementer
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


module TB_decrementer();

    reg clk = 0;
    reg [14:0]valReg = 0;
    
    wire[14:0] postVal;
    wire flash2s;
    wire flash1s;

always #1 clk = ~clk;

Decrementer D(clk,
 valReg, postVal, flash2s, flash1s
);

initial begin
    valReg = 9999;
    #2
    valReg = postVal;
    #1
    valReg = postVal;
    #1
    valReg = postVal;
    #1
    valReg = postVal;
    #1
    valReg = postVal;
    #1
    
    
    valReg = 202;
    #1
    valReg = postVal;
    #1
    valReg = postVal;
    #1
    valReg = postVal;
    #1
    valReg = postVal;
    #1
    valReg = postVal;
    
    #1
    valReg = 3;
    #1
    valReg = postVal;
    #1
    valReg = postVal;
    #1
    valReg = postVal;
    #1
    valReg = postVal;
    #1
    valReg = postVal;
end

endmodule
