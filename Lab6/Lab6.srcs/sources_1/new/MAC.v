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
    
    Float_Mult mult(clk, startMult, B, C, 0, 0, product, opDone[0]);
    Float_Add add(clk, startAdd, A, product, opDone[1], 0, 0, sum);
    
    always @(posedge clk) begin
    
        if(started) begin
            startMult = 0;
            if(opDone[0]) begin
                startAdd = 1;
            end
            else if(opDone[1]) begin
                startAdd = 0;
                done = 1;
                started = 0;
                A = sum;
            end
            else begin
                startAdd = 0;
            end
        end
        else begin
            if(start) begin
                startMult = 1;
                startAdd = 0;
                done = 0;
                started = 1;
            end
            else done = 1;
        end
        
    end
    
endmodule