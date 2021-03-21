`timescale 1ns / 1ps
`define clkDiv (10*000001)
`define TPS (1000000000/`clkDiv)

module PulseGenerator(
    input clk,
    input start,
    input [1:0] mode,
    output reg pulse = 0,
    output reg debug2 = 0
    );
    
    /*
    00: 32 Hz
    01: 64 Hz
    10: 128 Hz
    11: Hybrid
    */
    
    reg[63:0] ticks = 0;
    reg[63:0] counter = 0;
    reg[31:0] seconds = 0;
    reg[31:0] period = 0;
    reg[31:0] lastSeconds = 0;
    reg[31:0] frequency = 0;
    reg[31:0] pulseCount = 0;
    
    reg lastStart = 0;
    
    always @(posedge clk) begin
        debug2 = !debug2; 
    
        if(!lastStart && start) begin
            ticks <= 0;
            counter <= 0;
            lastSeconds <= -1;
            pulseCount <= 0; 
        end
        lastStart = start;
    
       seconds = ticks / `TPS;
       if(mode == 2'b11) begin
           if(seconds < 1) frequency = 20;
           else if(seconds < 2) frequency = 33;
           else if(seconds < 3) frequency = 66;
           else if(seconds < 4) frequency = 27;
           else if(seconds < 5) frequency = 70;
           else if(seconds < 6) frequency = 30;
           else if(seconds < 7) frequency = 19;
           else if(seconds < 8) frequency = 30;
           else if(seconds < 9) frequency = 33;
           else if(seconds < 73) frequency = 69;
           else if(seconds < 79) frequency = 34;
           else if(seconds < 144) frequency = 124;
           else frequency = 0;
       end
       else begin
           if(mode == 2'b00) frequency = 32;
           else if(mode == 2'b01) frequency = 64;
           else frequency = 128;
       end
       
       if(!start) frequency = 0;
       
        period = `TPS / ((frequency*2)+1);
       
       if(lastSeconds != seconds) begin
           //   first pulse of the second, let's force it to low
           pulse <= 0;
           pulseCount <= 0;
           lastSeconds <= seconds;
           counter <= 0;
       end
       else if(counter >= period) begin
           counter <= 0;
           pulse <= !pulse;
       end
       else counter <= counter + 1;
       
       ticks <= ticks + 1;
    end
    
    
endmodule
