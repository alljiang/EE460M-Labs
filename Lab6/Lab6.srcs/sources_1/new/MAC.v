`timescale 1ns / 1ps

module MAC(
    input clk,
    input [7:0] B,
    input [7:0] C,
    input start,
    output reg[7:0] A = 8'b0,
    output reg[7:0] Bout,
    output reg[7:0] Cout
    );
    
    reg started = 0;
    reg startMult = 0;
    reg startAdd = 0;
    
    wire[7:0] product;
    wire[7:0] sum;
    
    Float_Mult mult(B, C, product);
    Float_Add add(1'b0, 1'b1, A, product, sum);
    
    always @(posedge clk) begin
        if(start) begin
            Bout = B;
            Cout = C;
            A = sum;
        end
        
    end
    
endmodule