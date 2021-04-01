`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/31/2021 08:19:04 PM
// Design Name: 
// Module Name: TB_decodeInput
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


module TB_decodeInput();
    reg clk = 0;
    reg[3:0] btns = 0;
    wire pop;
    wire push;
    wire subtract;
    wire add;
    wire clr;
    wire top;
    wire dec_addr;
    wire inc_addr;
    
Decode_Input test(clk, btns, pop, push, subtract, add, clr, top, dec_addr, inc_addr);

always #1 clk = ~clk;

initial begin
    btns = 4'b0010;
    #10
    btns = 4'b0000;
    #10
    
    btns = 4'b0001;
    #10
    btns = 4'b0000;
    #10
    
    btns = 4'b0110;
    #10
    btns = 4'b0000;
    #10
    
    btns = 4'b0101;
    #10
    btns = 4'b0000;
    #10
    
    btns = 4'b1010;
    #10
    btns = 4'b0000;
    #10
    
    btns = 4'b1001;
    #10
    btns = 4'b0000;
    #10
    
    btns = 4'b1110;
    #10
    btns = 4'b0000;
    #10
    
    btns = 4'b1101;
    #10
    btns = 4'b0000;
end   
endmodule
