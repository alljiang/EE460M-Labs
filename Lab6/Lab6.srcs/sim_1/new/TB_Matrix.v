`timescale 1ns / 1ps

module TB_Matrix();

reg clk = 0;
always #1 clk = ~clk;

reg [7:0] a00, a01, a02, a10, a11, a12, a20, a21, a22;
reg [7:0] b00, b01, b02, b10, b11, b12, b20, b21, b22;
reg [7:0] c00, c01, c02, c10, c11, c12, c20, c21, c22;

wire matrixComplete;
wire [7:0] aOut, bOut, cOut, dOut, eOut, fOut, gOut, hOut, iOut;

Matrix mat(

    clk,
    a00, a01, a02, a10, a11, a12, a20, a21, a22,
    b00, b01, b02, b10, b11, b12, b20, b21, b22,
    matrixComplete,
    aOut, bOut, cOut, dOut, eOut, fOut, gOut, hOut, iOut

    );
    

initial begin

    a00 = 8'b00100000; a01 = 8'b00100000; a02 = 8'b00110000;    //  0.5   0.5    1
    a10 = 8'b00100000; a11 = 8'b11000100; a12 = 8'b10111000;    //  0.5  -0.25  -1.5
    a20 = 8'b11000100; a21 = 8'b00100000; a22 = 8'b00110000;    // -0.25  0.5    1
    
    b00 = 8'b00110000; b01 = 8'b01000100; b02 = 8'b01000100;    //  1   2.5  2.5
    b10 = 8'b00110000; b11 = 8'b10100000; b12 = 8'b00110000;    //  1  -0.5  1
    b20 = 8'b00110000; b21 = 8'b00100000; b22 = 8'b00100000;    //  1   0.5  0.5
    
    //Expected:
    c00 = 8'b01000000; c01 = 8'b00111000; c02 = 8'b01000010;    //   2     1.5     2.25  
    c10 = 8'b10110100; c11 = 8'b00100100; c12 = 8'b00010000;    //  -1.25  0.625   0.25
    c20 = 8'b00110100; c21 = 8'b10011000; c22 = 8'b00011000;    //   1.25 -0.375   0.375

end   

endmodule
