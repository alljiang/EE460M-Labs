`timescale 1ns / 1ps

module DFF(D,CLK,Q);
input D, CLK;
output reg Q;
always @(posedge CLK) 
begin
    Q <= D; 
end
endmodule


module debounce(
    input clk,
    input K,
    output Kd
    );
wire Kbuf;

DFF FF1(K,clk,Kbuf);
DFF FF2(Kbuf,clk,Kd);
endmodule


module singlePulse(
    input clk,
    input syncPress,
    output reg pulse = 0
    );
    
    reg lastPress = 0;

always @(posedge clk)
begin
    if(!lastPress && syncPress && !pulse) pulse = 1;
    else pulse = 0;
    lastPress = syncPress;
end

endmodule