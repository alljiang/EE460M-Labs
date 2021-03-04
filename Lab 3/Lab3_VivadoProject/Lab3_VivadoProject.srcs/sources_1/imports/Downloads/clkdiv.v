`timescale 1ns / 1ps

module clkdiv(
    input clk,
    output fsmclk 
    );
    
    // div by 8
    reg count = 0;
    assign fsmclk = count; 
    always @(posedge clk) count = count + 1;

endmodule
