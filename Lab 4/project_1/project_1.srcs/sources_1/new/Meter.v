`timescale 1ns / 1ps

module Meter(
    input clk,
    input btnU, input btnL, input btnR, input btnD,
    input [1:0] sw,
    output [6:0] seg, output [3:0] anode
);
    
integer timeRemaining = 0;
wire[15:0] adderOutput;
wire[15:0] decrementerOutput;
wire clk_1s;
wire flash2s, flash1s;
wire btnU_filtered, btnD_filtered, btnR_filtered, btnL_filtered;
wire btnU_sp, btnD_sp, btnR_sp, btnL_sp;

Adder adder(clk, btnU_sp, btnD_sp, btnR_sp, btnL_sp, timeRemaining, adderOutput);
clkDiv clk1s(clk, clk_1s);
Decrementer decrementer(clk, timeRemaining, decrementerOutput, flash2s, flash1s);

debounce db_U(clk, btnU, btnU_filtered);
debounce db_D(clk, btnD, btnD_filtered);
debounce db_L(clk, btnL, btnL_filtered);
debounce db_R(clk, btnR, btnR_filtered);   

singlePulse sp_U(clk, btnU_filtered, btnU_sp);
singlePulse sp_D(clk, btnD_filtered, btnD_sp);
singlePulse sp_L(clk, btnL_filtered, btnL_sp);
singlePulse sp_R(clk, btnR_filtered, btnR_sp); 

always @(posedge clk) begin
    // check adder
    timeRemaining = adderOutput;
    timeRemaining = decrementerOutput;
end
    
endmodule
