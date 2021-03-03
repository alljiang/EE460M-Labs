`timescale 1ns / 1ps

module TB_PulseGenerator();

    reg clk = 0;
    reg[1:0] mode;
    wire pulse;
 
    always #1 clk = ~clk;
    
    PulseGenerator gen(clk, mode, pulse);
    
    initial begin
    
        mode = 2'b11;
    
    end

endmodule
