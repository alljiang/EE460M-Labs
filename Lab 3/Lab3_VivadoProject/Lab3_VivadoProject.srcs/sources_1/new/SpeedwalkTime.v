`timescale 1ns / 1ps
`define clkDiv 10
`define TPS (500000000/`clkDiv)

module SpeedwalkTime(
    input clk,
    input reset,
    input pulse,
    output [15:0] seconds
    );
    
   integer pulseCount = 0;
   reg[15:0] fastSecondsCount = 0;
   time tickCount = 0;
   
   assign seconds[15:0] = fastSecondsCount[15:0];
    
   reg lastPulse = 0;
    
   always @(posedge clk) begin
   
       if(reset) begin
           fastSecondsCount = 0;
           tickCount = 0;
           pulseCount = 0;
       end
       else begin
       
           if(!lastPulse && pulse) begin
                pulseCount = pulseCount + 1;
           end
           lastPulse = pulse;
           
           if(tickCount < 9 * `TPS) begin
               tickCount = tickCount + 1;
               if(tickCount % `TPS == 0) begin
                   if(pulseCount > 1) fastSecondsCount = fastSecondsCount + 1;
                   pulseCount = 0;
               end
           end
       end
       
   end
    
endmodule
