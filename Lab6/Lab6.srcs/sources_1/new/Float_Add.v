`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2021 03:36:17 PM
// Design Name: 
// Module Name: Float_Add
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


module Float_Add(
    input rst,
    input St,
    input [7:0] A,
    input [7:0] B,
    output reg[7:0] Sum = 0
    );

reg [7:0] sumBuf; // for signed operation
reg [4:0] fracBuf;
reg [2:0] expBuf;
reg signBuf;

initial begin 
    sumBuf = 0;
    fracBuf = 0;
    expBuf = 0;
    signBuf = 0;
end

//buffers for floating point components
reg [5:0] AFrac;    //add 2 extra bits for sign and implied 1
reg [2:0] AExp;
reg [5:0] BFrac;
reg [2:0] BExp;

always @(*) begin
    if(rst) begin
        Sum = 8'b00000000;
    end
    else if(St) begin
        AFrac = {1'b0,1'b1, A[3:0]};
        BFrac = {1'b0, 1'b1, B[3:0]};
        AExp = A[6:4];
        BExp = B[6:4];
        
        //AExp = A[6:4] - 3;
        //BExp = B[6:4] - 3;
        
        //A bigger exponent
        if(AExp > BExp)begin
            expBuf = AExp; 
            //shift smaller number, use larger exponent value
            BFrac = BFrac >> (AExp-BExp);
            
            //add fractions AND PAY ATTENTION TO SIGNS
            //check sign
            if(A[7]==1) AFrac = -AFrac;
            if(B[7]==1) BFrac = -BFrac;
            sumBuf = AFrac+BFrac;
            //sign extend padding
            sumBuf[5] = sumBuf[4];
            sumBuf[6] = sumBuf[4];
            sumBuf[7] = sumBuf[4];
            //convert back to absolute value
            if(sumBuf[5]==1) begin
                sumBuf = -sumBuf;
                signBuf = 1;
            end
            
            //normalize fractions
            fracBuf = sumBuf[4:0]; //chop off extra sign bits
            if(fracBuf[4]==0 && fracBuf[3]==0) begin
                fracBuf = fracBuf << 1;
                expBuf = expBuf - 1;
                if(fracBuf[4]==0 && fracBuf[3]==0)begin
                    fracBuf = fracBuf << 1;
                    expBuf = expBuf - 1;
                end
                if(fracBuf[4]==0 && fracBuf[3]==0)begin
                    fracBuf = fracBuf << 1;
                    expBuf = expBuf - 1;
                end
                if(fracBuf[4]==0 && fracBuf[3]==0)begin
                    fracBuf = fracBuf << 1;
                    expBuf = expBuf - 1;
                end
                if(fracBuf[4]==0 && fracBuf[3]==0)begin
                    fracBuf = fracBuf << 1;
                    expBuf = expBuf - 1;
                end    
            end
        end
        
        //B bigger exponent
        else if (AExp < BExp) begin
            expBuf = BExp; 
            //shift smaller number, use larger exponent value
            AFrac = AFrac >> (BExp-AExp);
            
            //add fractions AND PAY ATTENTION TO SIGNS
            //check sign
            if(A[7]==1) AFrac = -AFrac;
            if(B[7]==1) BFrac = -BFrac;
            sumBuf = AFrac+BFrac;
            //sign extend padding
            sumBuf[5] = sumBuf[4];
            sumBuf[6] = sumBuf[4];
            sumBuf[7] = sumBuf[4];
            //convert back to absolute value
            if(sumBuf[5]==1) begin
                sumBuf = -sumBuf;
                signBuf = 1;
            end
            
            //normalize fractions
            fracBuf = sumBuf[4:0]; //chop off extra sign bits
            if(fracBuf[4]==0 && fracBuf[3]==0) begin
                fracBuf = fracBuf << 1;
                expBuf = expBuf - 1;
                if(fracBuf[4]==0 && fracBuf[3]==0)begin
                    fracBuf = fracBuf << 1;
                    expBuf = expBuf - 1;
                end
                if(fracBuf[4]==0 && fracBuf[3]==0)begin
                    fracBuf = fracBuf << 1;
                    expBuf = expBuf - 1;
                end
                if(fracBuf[4]==0 && fracBuf[3]==0)begin
                    fracBuf = fracBuf << 1;
                    expBuf = expBuf - 1;
                end
                if(fracBuf[4]==0 && fracBuf[3]==0)begin
                    fracBuf = fracBuf << 1;
                    expBuf = expBuf - 1;
                end    
            end
        end
        
        //Exponents Equal
        else begin
            expBuf = AExp;
            //add fractions AND PAY ATTENTION TO SIGNS
            //check sign
            if(A[7]==1) AFrac = -AFrac;
            if(B[7]==1) BFrac = -BFrac;
            sumBuf = AFrac + BFrac;
            //sign extend padding
            sumBuf[5] = sumBuf[4];
            sumBuf[6] = sumBuf[4];
            sumBuf[7] = sumBuf[4];
            //convert back to absolute value
            if(sumBuf[5]==1) begin
                sumBuf = -sumBuf;
                signBuf = 1;
            end
           
            //normalize fractions
            fracBuf = sumBuf[4:0]; //chop off extra sign bits
            if(fracBuf[4]==0 && fracBuf[3]==0) begin
                fracBuf = fracBuf << 1;
                expBuf = expBuf - 1;
                if(fracBuf[4]==0 && fracBuf[3]==0)begin
                    fracBuf = fracBuf << 1;
                    expBuf = expBuf - 1;
                end
                if(fracBuf[4]==0 && fracBuf[3]==0)begin
                    fracBuf = fracBuf << 1;
                    expBuf = expBuf - 1;
                end
                if(fracBuf[4]==0 && fracBuf[3]==0)begin
                    fracBuf = fracBuf << 1;
                    expBuf = expBuf - 1;
                end
                if(fracBuf[4]==0 && fracBuf[3]==0)begin
                    fracBuf = fracBuf << 1;
                    expBuf = expBuf - 1;
                end    
            end
        end
        Sum = {signBuf, expBuf-3, fracBuf[3:0]};
                
        if(A == 0 && B==0) Sum = 8'b00000000;
    end
end

endmodule