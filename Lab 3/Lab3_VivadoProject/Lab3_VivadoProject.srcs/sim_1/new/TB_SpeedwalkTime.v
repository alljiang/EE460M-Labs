`timescale 1ns / 1ps

module TB_SpeedwalkTime();

reg clk = 0;
reg start = 0;
reg[1:0] mode;
wire pulse;

always #1000 clk = ~clk;

PulseGenerator gen(clk, start, mode, pulse);

reg reset = 0;
wire [15:0] seconds;
wire [15:0] pulsecount;

SpeedwalkTime nyoooooom(clk, reset, pulse, seconds, pulsecount);  

initial begin
    mode = 2'b11;
    start = 1;
    #2000000000;
    #2000000000;
    #2000000000;
    reset = 1;
    #500000000;
    reset = 0;
    
end

endmodule
