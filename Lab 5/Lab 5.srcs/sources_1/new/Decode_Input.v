`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/31/2021 07:51:19 PM
// Design Name: 
// Module Name: Decode_Input
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


module Decode_Input(
    input clk,
    input[3:0] btns,
    output reg pop,
    output reg push,
    output reg subtract,
    output reg add,
    output reg clr,
    output reg top,
    output reg dec_addr,
    output reg inc_addr
    );

wire[3:0] btnPulse;

assign btnPulse[3:2] = { btns[3], btns[2] };
singlePulse btn1(clk, btns[1], btnPulse[1]);
singlePulse btn0(clk, btns[0], btnPulse[0]);

always @(btnPulse)
case(btnPulse)
    4'b0001: begin
        pop = 0;
        push = 1;
        subtract = 0;
        add = 0;
        clr = 0;
        top = 0;
        dec_addr = 0;
        inc_addr = 0;
    end
    4'b0010: begin
        pop = 1;
        push = 0;
        subtract = 0;
        add = 0;
        clr = 0;
        top = 0;
        dec_addr = 0;
        inc_addr = 0;
    end
    4'b0101: begin
        pop = 0;
        push = 0;
        subtract = 0;
        add = 1;
        clr = 0;
        top = 0;
        dec_addr = 0;
        inc_addr = 0;
    end
    4'b0110: begin
        pop = 0;
        push = 0;
        subtract = 1;
        add = 0;
        clr = 0;
        top = 0;
        dec_addr = 0;
        inc_addr = 0;
    end
    4'b1001: begin
        pop = 0;
        push = 0;
        subtract = 0;
        add = 0;
        clr = 0;
        top = 1;
        dec_addr = 0;
        inc_addr = 0;
    end
    4'b1010: begin
        pop = 0;
        push = 0;
        subtract = 0;
        add = 0;
        clr = 1;
        top = 0;
        dec_addr = 0;
        inc_addr = 0;
    end
    4'b1101: begin
        pop = 0;
        push = 0;
        subtract = 0;
        add = 0;
        clr = 0;
        top = 0;
        dec_addr = 0;
        inc_addr = 1;
    end
    4'b1110: begin
        pop = 0;
        push = 0;
        subtract = 0;
        add = 0;
        clr = 0;
        top = 0;
        dec_addr = 1;
        inc_addr = 0;
    end 
    
    default begin
        pop = 0;
        push = 0;
        subtract = 0;
        add = 0;
        clr = 0;
        top = 0;
        dec_addr = 0;
        inc_addr = 0;
    end
endcase 
endmodule
