`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2021 08:46:15 PM
// Design Name: 
// Module Name: pulse_debounce
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
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
    output reg pulse
    );
reg cs, ns;

initial begin
    cs <= 0;
    ns <= 0;
end  

always @(cs, syncPress) begin
case(cs) 
    0: begin
        if(syncPress == 1) begin
         
            ns <= 1; 
            pulse <= 1;
        end
        else begin 
            //should be <= 0; this is for debugging only
            ns <= 0;
            pulse <= 0;
        end
    end
    1: begin
        if(syncPress == 1) begin
            ns <= 1;
            pulse <= 0;
        end
        else begin
            ns <= 0; 
            pulse <= 0;
        end
    end
    //should not happen
    default: begin
    end
endcase 
end

always @(posedge clk)
begin
    cs <= ns;
end

endmodule