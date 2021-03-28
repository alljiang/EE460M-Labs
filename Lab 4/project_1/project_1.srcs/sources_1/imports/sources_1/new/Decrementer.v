`timescale 1ns / 1ps

//`define clkdiv 100000
`define clkdiv 1

`define DELAY1s (50000000 / `clkdiv) //one second delay
`define DELAY2s (100000000 / `clkdiv) //2 second delay

module clkDiv(
    input clk, 
    output reg slowClk = 0
    );
    
time clkBuf = 0;

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
    input [15:0] valReg,
    output reg[15:0] postVal = 0,
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