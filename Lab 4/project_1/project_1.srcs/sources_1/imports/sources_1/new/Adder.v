`timescale 1ns / 1ps

module Adder(
    input clk,
    input btnU, btnD, btnR, btnL,
    input [15:0] regVal,
    output reg[15:0] toDecr = 0
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
        toDecr = 0;
    end
end
    
endmodule
