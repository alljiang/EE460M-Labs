`timescale 1ns / 1ps
`define clkDiv 10
`define TPS (500000000/`clkDiv)

module SpeedwalkTime(
    input clk,
    input reset,
    input pulse,
    output [15:0] seconds
    );
    
   reg[31:0] pulseCount = 0;
   reg[31:0] fastSecondsCount = 0;
   reg[63:0] tickCount = 0;
   
   assign seconds = fastSecondsCount[15:0];
    
    reg lastReset = 0;
    reg lastPulse = 0;
    
   always @(posedge clk) begin
   
       if(!lastReset && reset) begin
           fastSecondsCount = 0;
           tickCount = 0;
           pulseCount = 0;
       end
       lastReset = reset;
       
       if(!lastPulse && pulse) begin
            pulseCount = pulseCount + 1;
       end
       lastPulse = pulse;
       
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
    
endmodule
