`timescale 1ns / 1ps

module PulseGenerator(
    input clk,
    input [1:0] mode,
    output pulse
    );
    
    /*
    00: 32 Hz
    01: 64 Hz
    10: 128 Hz
    11: Hybrid
    */
    
    time nanos;
    integer seconds;
    integer period;
    integer lastSeconds;
    integer frequency;
    
    reg outputPulse;
    assign pulse = outputPulse;
    
    always @(mode) begin
        nanos = 0;
        outputPulse = 0;
        lastSeconds = -1;
    end
    
    always @(posedge clk) begin
       seconds = nanos / 1000000000;
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
       
        period = 1000000000/((frequency*4)+1);
       
       if(lastSeconds != seconds) begin
           //   first pulse of the second, let's force it to low
           outputPulse = 0;
           lastSeconds = seconds;
       end
       else if(nanos % period == 0) outputPulse = !outputPulse;
       
       nanos = nanos + 1;
    end
    
    
endmodule
