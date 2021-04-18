`timescale 1ns / 1ps

module MAC(
    input clk,
    input [7:0] B,
    input [7:0] C,
    input start,
    output reg[7:0] A = 0,
    output reg[7:0] Bout = 0,
    output reg[7:0] Cout = 0,
    output reg done = 1
    );
    
    reg started = 0;
    reg startMult = 0;
    reg startAdd = 0;
    
    wire[7:0] product;
    wire[7:0] sum;
    
    wire[1:0] opDone;
    
    Float_Mult mult(B, C, product);
    Float_Add add(A, product, sum);
    
    always @(posedge clk) begin
        if(start) begin
            A = sum;
        end
        
    end
    
endmodule