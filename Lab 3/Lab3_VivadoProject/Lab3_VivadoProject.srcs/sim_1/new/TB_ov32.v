`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/10/2021 10:13:05 AM
// Design Name: 
// Module Name: TB_ov32
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


module TB_ov32();
    reg CLK = 0;
    reg rst = 0;
    reg [15:0]count = 0;
    wire [3:0]numOv32;

always #1 CLK = ~CLK;
over32 check(CLK, rst, count, numOv32);

initial begin
    #199
        count = count + 10;
    #100
        count = count + 35;
    #100
        count = count + 35;
    #100
        count = count + 50;
    #100
        count = count + 10;
    #100
        count = count + 0;
    #100
        count = count + 10;
    #100
        count = count + 50;
    #100
        count = count + 150;
    //from now on shouldn't update
    #100
        count = count + 100;
    #100
        count = count + 100;
    #100
        rst = 1; 
        //count = count + 35;
    #100
        rst = 0; 
        count = count + 35;
    #100
        count = count + 50; 
    
end

endmodule
