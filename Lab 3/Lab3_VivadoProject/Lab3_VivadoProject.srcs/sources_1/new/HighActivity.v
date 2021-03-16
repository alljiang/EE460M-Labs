`timescale 1ns / 1ps
`define clkDiv 10
`define TPS (500000000/`clkDiv)

module HighActivity(
    input clk,
    input reset,
    input pulse,
    output [15:0] highActivityTime
    );
    
    reg[31:0] totalActivityTime = 0;
    reg[31:0] currentActivityTime = 0;
    reg[63:0] tickCount = 0;
    reg[31:0] stepCountThisSecond = 0;
    
    assign highActivityTime = totalActivityTime[15:0];
    
    reg lastReset = 0;
    reg lastPulse = 0;
    
    always @(posedge clk) begin
    
        if(!lastReset && reset) begin
            tickCount = 0;
            currentActivityTime = 0;
            totalActivityTime = 0;
            stepCountThisSecond = 0;
        end
        lastReset = reset;
        
        if(!lastPulse && pulse) begin
            stepCountThisSecond = stepCountThisSecond + 1;
        end
    
        if(tickCount % `TPS == 0) begin
            //  end of a second
            if(stepCountThisSecond >= 64) currentActivityTime = currentActivityTime + 1;
            else currentActivityTime = 0; 
            
            if(currentActivityTime == 60) totalActivityTime = totalActivityTime + 60;
            else if(currentActivityTime > 60) totalActivityTime = totalActivityTime + 1; 
            stepCountThisSecond = 0;
        end
    
        tickCount = tickCount + 1;
    end
    
endmodule
