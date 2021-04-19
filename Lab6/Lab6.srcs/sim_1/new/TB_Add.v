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
    A = 7'b00100000; //0.5
    B = 7'b00100000; //0.5
    if(Sum != 7'b00110000) 
        $display("case incorrect");
    #20
    
    St = 0;
    A = 7'b00110000; //1
    B = 7'b00010100; //0.3125
    if(Sum != 7'b00010100) 
        $display("case incorrect");
    #20
    
    St = 1;
    A = 7'b00000000;
    B = 7'b00000000; //?
    if(Sum != 7'b00000000) 
        $display("case incorrect");
    #20
    
    A = 7'b00000000;
    B = 7'b00110101; //?
    if(Sum != 7'b00110101) 
        $display("case incorrect");

end

endmodule
