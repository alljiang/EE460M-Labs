`timescale 1ns / 1ps

module Meter(
    input clk,
    input btnU, input btnL, input btnR, input btnD,
    input [1:0] sw,
    output [6:0] seg, output [3:0] an, output reg dp = 1
);
    
reg[15:0] timeRemaining = 0;
wire[15:0] adderOutput;
wire[15:0] decrementerOutput;
wire clk_1s;
wire flash2s, flash1s;
wire btnU_filtered, btnD_filtered, btnR_filtered, btnL_filtered;
wire btnU_sp, btnD_sp, btnR_sp, btnL_sp;

Adder adder(clk, btnU_sp, btnD_sp, btnR_sp, btnL_sp, timeRemaining, adderOutput);
clkDiv clk1s(clk, clk_1s);
Decrementer decrementer(clk, timeRemaining, decrementerOutput, flash2s, flash1s);

wire none;
sevenseg ss(clk, timeRemaining, 0, none, an, seg);

debounce db_U(clk, btnU, btnU_filtered);
debounce db_D(clk, btnD, btnD_filtered);
debounce db_L(clk, btnL, btnL_filtered);
debounce db_R(clk, btnR, btnR_filtered);   

singlePulse sp_U(clk, btnU_filtered, btnU_sp);
singlePulse sp_D(clk, btnD_filtered, btnD_sp);
singlePulse sp_L(clk, btnL_filtered, btnL_sp);
singlePulse sp_R(clk, btnR_filtered, btnR_sp); 

reg lastclk_1s = 0;

always @(posedge clk) begin
    if(lastclk_1s && !clk_1s) timeRemaining = decrementerOutput;
    lastclk_1s = clk_1s;
    
    if(sw == 2'b01) timeRemaining = 10;
    else if(sw == 2'b10) timeRemaining = 205;
    else if(adderOutput > 0) timeRemaining = adderOutput;
end
    
endmodule
