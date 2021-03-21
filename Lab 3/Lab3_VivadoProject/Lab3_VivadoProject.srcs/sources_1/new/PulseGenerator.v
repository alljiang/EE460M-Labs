`timescale 1ns / 1ps
`define clkDiv (10*00001)
`define TPS (1000000000/`clkDiv)

module PulseGenerator(
    input clk,
    input start,
    input reset,
    input [1:0] mode,
    output reg pulse = 0
    );
    
    /*
    00: 32 Hz
    01: 64 Hz
    10: 128 Hz
    11: Hybrid
    */
    
    time tickSecondCounter = `TPS;
    time ticks = 0;
    time counter = 0;
    integer seconds = 0;
    integer period = 0;
    integer lastSeconds = 0;
    integer frequency = 0;
    integer pulseCount = 0;
    
    reg lastStart = 0;
    
    always @(posedge clk) begin
    
        if(!lastStart && start) begin
            ticks <= 0;
            counter <= 0;
            lastSeconds <= -1;
            pulseCount <= 0; 
            pulse <= 0;
        end
        lastStart = start;
        
        if(reset) begin
            ticks <= 0;
            counter <= 0;
            seconds <= 0;
            period <= 0;
            lastSeconds <= 0;
            frequency <= 0;
            pulseCount <= 0;
            pulse <= 0;
            tickSecondCounter <= `TPS;
        end
    
       if(!start) period <= `TPS;
       else if(mode == 2'b11) begin
           seconds <= ticks / `TPS;
           if(seconds < 1) period <= `TPS / ((20*2)+1);
           else if(seconds < 2) period <= `TPS / ((33*2)+1);
           else if(seconds < 3) period <= `TPS / ((66*2)+1);
           else if(seconds < 4) period <= `TPS / ((27*2)+1);
           else if(seconds < 5) period <= `TPS / ((70*2)+1);
           else if(seconds < 6) period <= `TPS / ((30*2)+1);
           else if(seconds < 7) period <= `TPS / ((19*2)+1);
           else if(seconds < 8) period <= `TPS / ((30*2)+1);
           else if(seconds < 9) period <= `TPS / ((33*2)+1);
           else if(seconds < 73) period <= `TPS / ((69*2)+1);
           else if(seconds < 79) period <= `TPS / ((34*2)+1);
           else if(seconds < 144) period <= `TPS / ((124*2)+1);
           else period <= `TPS;
       end
       else begin
           if(mode == 2'b00) period <= `TPS / ((32*2)+1);
           else if(mode == 2'b01) period <= `TPS / ((64*2)+1);
           else period <= `TPS / ((128*2)+1);
       end
       
       if(tickSecondCounter >= `TPS) begin
           //   first pulse of the second, let's force it to low
           pulse <= 0;
           pulseCount <= 0;
           counter <= 0;
           tickSecondCounter <= 1;
       end
       else if(counter >= period) begin
           counter <= 0;
           pulse <= !pulse;
           tickSecondCounter <= tickSecondCounter + 1;
       end
       else begin
           counter <= counter + 1;
           tickSecondCounter <= tickSecondCounter + 1;
       end
              
       ticks <= ticks + 1;
    end
    
    
endmodule
