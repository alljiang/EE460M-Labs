`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2021 02:58:19 PM
// Design Name: 
// Module Name: TB_singlePulseDebounce
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


module TB_singlePulseDebounce();

reg clk = 0;
reg button = 0;
reg slowClk = 0;

wire dbSignal;
wire pulse;

always #1 clk = ~clk;
always #50 slowClk = ~slowClk;

//DFF FF1t(button,clk,Kbuf);
//DFF FF2t(Kbuf,clk,dbSignal);
debounce dB(
slowClk, button, dbSignal);

singlePulse sP(slowClk, dbSignal, pulse);
    
initial begin
//simulate bouncing
    button = 1;
    #1
    button = 0;
    #1
    button = 1;
    #1
    button = 0;
    #1
    button = 1;
    #1
    button = 0;
    #1
    button = 1;
    #1
    button = 0;
    #1
    button = 1;
    #1
    button = 0;
    #1
    
//stabilized button signal
    button = 1;
    #500
    
    button = 0;
    #1
    button = 1;
    #1
    button = 0;
    #1
    button = 1;
    #1
    button = 0;
    #1
    button = 1;
    #1
    button = 0;
    #1
    button = 1;
    #1
    button = 0;
   
end



    
endmodule
