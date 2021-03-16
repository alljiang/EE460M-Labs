`timescale 1ns / 1ps

module clkdiv(
    input clk,
    output fsmclk 
    );
    
    reg [10:0] count = 0;
    reg out = 0;
    assign fsmclk = out; 
    
    always @(posedge clk) begin 
        count = count + 1;
        if(count == 0) out = !out;
    end

endmodule
