`timescale 1ns / 1ps
`define clkDiv (10*00001)
`define TPS (1000000000/`clkDiv)

module SpeedwalkTime(
    input clk,
    input reset,
    input pulse,
    output [15:0] seconds
    );
    
   integer pulseCount = 0;
   integer secondsCount = 0;
   reg[15:0] fastSecondsCount = 0;
   time tickCount = 0;
   
   assign seconds[15:0] = fastSecondsCount[15:0];
    
   reg lastPulse = 0;
    
   always @(posedge clk) begin
   
       if(reset) begin
           secondsCount <= 0;
           fastSecondsCount <= 0;
           tickCount <= 0;
           pulseCount <= 0;
           lastPulse <= 0;
       end
       else begin
       
           if(!lastPulse && pulse) begin
                pulseCount <= pulseCount + 1;
           end
           lastPulse <= pulse;
           
           if(secondsCount <= 9) begin
               tickCount <= tickCount + 1;
               if(tickCount >= secondsCount * `TPS) begin
                   secondsCount <= secondsCount + 1;
                   if(pulseCount > 32) fastSecondsCount <= fastSecondsCount + 1;
                   pulseCount <= 0;
               end
           end
       end
       
   end
    
endmodule