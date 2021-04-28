`timescale 1ns / 1ps

module Float_Add(
    input rst,
    input St,
    input [7:0] A,
    input [7:0] B,
    output reg[7:0] Sum = 0
    );

reg [5:0] sumBuf; // for signed operation
reg [10:0] fracBuf;
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
        
        //A bigger exponent
        if(AExp > BExp)begin
            expBuf = AExp; 
            //shift smaller number, use larger exponent value
            BFrac = BFrac >> (AExp-BExp);
        end
        
        //B bigger exponent
        else if (AExp < BExp) begin
            expBuf = BExp; 
            //shift smaller number, use larger exponent value
            AFrac = AFrac >> (BExp-AExp);
        end
        
        //Exponents Equal
        else begin
            expBuf = AExp;
        end
        
        signBuf = 0;
        if(A[7] == B[7]) signBuf = A[7];
        else begin
            if(AFrac > BFrac) begin
                signBuf = A[7];
                BFrac = ~BFrac + 1;
            end                
            else if(AFrac < BFrac) begin
                signBuf = B[7];
                AFrac = ~AFrac + 1;
            end
            else signBuf = 0;
        end
        
        sumBuf = AFrac + BFrac;
        
        //normalize fractions
        fracBuf = sumBuf[5:0]; //chop off extra sign bits
        if(fracBuf >= 6'b100000) begin
            fracBuf = fracBuf >> 1;
            expBuf = expBuf + 1;
        end
        if(fracBuf >= 6'b100000) begin
            fracBuf = fracBuf >> 1;
            expBuf = expBuf + 1;
        end
        if(fracBuf >= 6'b100000) begin
            fracBuf = fracBuf >> 1;
            expBuf = expBuf + 1;
        end
        if(fracBuf >= 6'b100000) begin
            fracBuf = fracBuf >> 1;
            expBuf = expBuf + 1;
        end
        if(fracBuf >= 6'b100000) begin
            fracBuf = fracBuf >> 1;
            expBuf = expBuf + 1;
        end
        if(fracBuf >= 6'b100000) begin
            fracBuf = fracBuf >> 1;
            expBuf = expBuf + 1;
        end
        if(fracBuf >= 6'b100000) begin
            fracBuf = fracBuf >> 1;
            expBuf = expBuf + 1;
        end
        if(fracBuf < 6'b10000) begin
            fracBuf = fracBuf << 1;
            expBuf = expBuf - 1;
        end
        if(fracBuf < 6'b10000) begin
            fracBuf = fracBuf << 1;
            expBuf = expBuf - 1;
        end
        if(fracBuf < 6'b10000) begin
            fracBuf = fracBuf << 1;
            expBuf = expBuf - 1;
        end
        if(fracBuf < 6'b10000) begin
            fracBuf = fracBuf << 1;
            expBuf = expBuf - 1;
        end
        if(fracBuf < 6'b10000) begin
            fracBuf = fracBuf << 1;
            expBuf = expBuf - 1;
        end
        
        Sum = {signBuf, expBuf[2:0], fracBuf[3:0]};
                
        if(  (A[7] != B[7]) && (A[6:0] == B[6:0]) ) Sum = 8'b0; 
                
        if(A == 0 && B==0) Sum = 8'b0;
        else if(A == 0) Sum = B;
        else if(B == 0) Sum = A;
    end
end

endmodule