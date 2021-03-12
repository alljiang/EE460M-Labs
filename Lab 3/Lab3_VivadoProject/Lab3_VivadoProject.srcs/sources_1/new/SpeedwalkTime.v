`timescale 1ns / 1ps
`define clkDiv 1
`define TPS (500000000/`clkDiv)

module SpeedwalkTime(
    input clk,
    input reset,
    input pulse,
    output [15:0] seconds
    );
    
   integer pulseCount = 0;
   integer fastSecondsCount = 0;
   time tickCount = 0;
   
   assign seconds = fastSecondsCount[15:0];
   //assign test1 = pulseCount[15:0];
    
   always @(posedge clk) begin
       if(reset) begin
           fastSecondsCount = 0;
       end
       if(tickCount > 9 * `TPS) begin
           
       end
       else begin
           tickCount = tickCount + 1;
           
           if(tickCount % `TPS == 0) begin
               if(pulseCount > 32) fastSecondsCount = fastSecondsCount + 1;
               pulseCount = 0;
           end
       end
       
   end
   
   always @(negedge reset) begin
       tickCount = 0;
       pulseCount = 0;
       fastSecondsCount = 0;
   end
      
   always @(posedge pulse) begin
       pulseCount = pulseCount + 1;
   end  
    
endmodule
