`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2021 10:23:10 AM
// Design Name: 
// Module Name: TB_Mult
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


module TB_Mult();
    reg [7:0]A = 0;
    reg [7:0]B = 0;

    wire[7:0] prod;


Float_Mult T1(
 A,
 B,
 prod
);

initial begin  
    A = 7'b00100000; //0.5
    B = 7'b00100000; //0.5
    if(prod != 7'b00010000) 
        $display("case incorrect");
    #20
    
    A = 7'b00110000; //1
    B = 7'b00010100; //0.3125
    if(prod != 7'b00010100) 
        $display("case incorrect");
    #20
    
    A = 7'b00000000;
    B = 7'b00110101; //?
    #20
    if(prod != 7'b00000000) 
        $display("case incorrect");

end
    
endmodule
