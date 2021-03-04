`timescale 1ns / 1ps

module TB_PulseGenerator();

    reg clk = 0;
    reg start = 0;
    reg[1:0] mode;
    wire pulse;
 
    always #1000 clk = ~clk;
    
    PulseGenerator gen(clk, start, mode, pulse);
    
    initial begin
        mode = 2'b10;
        start = 0;
        #1000
        start = 1;
        #300000000
        start = 0;
    
    end

endmodule
