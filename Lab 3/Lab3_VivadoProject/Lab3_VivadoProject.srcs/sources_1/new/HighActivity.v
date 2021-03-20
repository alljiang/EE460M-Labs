`timescale 1ns / 1ps
`define clkDiv (10*00001)
`define TPS (1000000000/`clkDiv)

module HighActivity(
    input clk,
    input reset,
    input pulse,
    output [15:0] highActivityTime
    );
    
    integer totalActivityTime = 0;
    integer currentActivityTime = 0;
    time tickCount = 0;
    integer stepCountThisSecond = 0;
    
    assign highActivityTime = totalActivityTime[15:0];
//    assign highActivityTime = stepCountThisSecond[15:0];
   
    reg lastPulse = 0;
    
    always @(posedge clk) begin
    
        if(reset) begin
            tickCount = 0;
            currentActivityTime = 0;
            totalActivityTime = 0;
            stepCountThisSecond = 0;
            lastPulse = 0;
        end
        else begin
            if(!lastPulse && pulse) begin
                stepCountThisSecond = stepCountThisSecond + 1;
            end
            lastPulse = pulse;
        
            if(tickCount >= `TPS) begin
                tickCount = 0;
            
                //  end of a second
                if(stepCountThisSecond >= 64) currentActivityTime = currentActivityTime + 1;
                else currentActivityTime = 0; 
                
                if(currentActivityTime == 60) totalActivityTime = totalActivityTime + 60;
                else if(currentActivityTime > 60) totalActivityTime = totalActivityTime + 1; 
                stepCountThisSecond = 0;
            end
            else tickCount = tickCount + 1;
        end        
    end
    
endmodule
