`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2021 03:36:17 PM
// Design Name: 
// Module Name: Float_Mult
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


module Float_Mult(
    input [7:0]A,
    input [7:0]B,
    output reg[7:0] prod
    );

reg [9:0] prodBuf;
reg [3:0] expBuf;
reg ov;
wire sign; 

assign sign = A[7]^B[7];

wire [4:0] AFrac;
wire [2:0] AExp;
wire [4:0] BFrac;
wire [2:0] BExp;
assign AFrac = {1'b1, A[3:0]};
assign BFrac = {1'b1, B[3:0]};
assign AExp = A[6:4] - 3; //exp offset = 3
assign BExp = B[6:4] - 3;

always @(*) begin
    //0 case
    if(A==0 || B==0) begin
        expBuf = 0;
        prodBuf = 0;
    end
    
    else begin
        prodBuf = AFrac * BFrac;
        expBuf = AExp + BExp + 3;   //exponent with offset applied
        
        //check overflow 
        if(prodBuf[9]==1)begin 
            prodBuf = prodBuf >> 1;
            expBuf = expBuf + 1;
        end
        
        //check normalized
        else if(prodBuf[9]==0 && prodBuf[8]==0) begin
            //8 left shifts ensure floating point normalization
            prodBuf = prodBuf << 1; 
            expBuf = expBuf - 1;
            
            if(prodBuf[9]==0 && prodBuf[8]==0) begin
                prodBuf = prodBuf << 1; 
                expBuf = expBuf - 1;
            end
            if(prodBuf[9]==0 && prodBuf[8]==0) begin
                prodBuf = prodBuf << 1; 
                expBuf = expBuf - 1;
            end
            if(prodBuf[9]==0 && prodBuf[8]==0) begin
                prodBuf = prodBuf << 1; 
                expBuf = expBuf - 1;
            end
            if(prodBuf[9]==0 && prodBuf[8]==0) begin
                prodBuf = prodBuf << 1; 
                expBuf = expBuf - 1;
            end
            if(prodBuf[9]==0 && prodBuf[8]==0) begin
                prodBuf = prodBuf << 1; 
                expBuf = expBuf - 1;
            end
            if(prodBuf[9]==0 && prodBuf[8]==0) begin
                prodBuf = prodBuf << 1; 
                expBuf = expBuf - 1;
            end
            if(prodBuf[9]==0 && prodBuf[8]==0) begin
                prodBuf = prodBuf << 1; 
                expBuf = expBuf - 1;
            end
        end
        
    end
    //load output reg
        prod[7] = sign; 
        prod[6:4] = expBuf[2:0]; 
        prod[3:0] = prodBuf[7:4];
end
      

endmodule