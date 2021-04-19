`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2021 10:23:10 AM
// Design Name: 
// Module Name: TB_Add
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


module TB_Add();
    reg St = 0;
    reg rst = 0;
    reg [7:0]A = 0;
    reg [7:0]B = 0;

    wire[7:0] Sum;


Float_Add A1(
    rst,
    St,
    A,
    B,
    Sum
    );

initial begin  
    St = 1;
    
    
    A = 8'b00100000; //0.5
    B = 8'b00100000; //0.5
    #20
    if(Sum != 8'b00110000) 
        $display("case 1 incorrect");
    
    St = 1;
    A = 8'b00010111;    //  0.359375
    B = 8'b00011001;    //  0.39063
    #20
    if(Sum != 8'b00101000)  //  0.75
        $display("case 2 incorrect");
    
    St = 1;
    A = 8'b01100000;
    B = 8'b01000100; 
    #20
    if(Sum != 8'b01100101)  //  10.5 
        $display("case 3 incorrect");
    
    A = 8'b10011000;    //  -0.375
    B = 8'b11000001;    //  -2.125
    #20
    if(Sum != 8'b11000100)  //  -2.5 
        $display("case 4 incorrect");
    
    A = 8'b00110100;    //  1.25  
    B = 8'b10111000;    //  -1.5  
    #20
    if(Sum != 8'b10010000)  //  -0.25 
        $display("case 5 incorrect");

end

endmodule