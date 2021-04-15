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
    input CLK,
    input St,
    input [7:0] A,
    input [7:0] B,
    output reg done,
    output reg expOv,
    output reg[7:0] Sum
    );

reg [5:0] sumBuf;
reg [3:0] expBuf;

//control signals
reg fracOv;
reg expNoEq;
reg LoadRegs;
reg needNorm;

//buffers for floating point components
reg [4:0] AFrac;
reg [2:0] AExp;
reg [4:0] BFrac;
reg [2:0] BExp;

reg [1:0] CS;
reg [1:0] NS;

initial begin
    sumBuf = 0;
    expBuf = 0;
    CS = 0;
    NS = 0;
end

always @(posedge CLK) begin
    case(CS) 
        0: begin
            done <= 0;
            if(St) begin
                LoadRegs <= 1;
                NS <= 1;
            end
            else NS <= 0;
        end
        1: begin
            done <= 0;
            if(AFrac != BFrac) begin //keep shifting until exp equal
                expNoEq = 1;
                NS <= 1;
            end
            else begin
                expNoEq = 0;
                NS <= 2;
            end
        end
        2: begin //now that exp equal add fracs
            done <= 0;
            sumBuf = AFrac + BFrac; 
            if(sumBuf == 0) begin
                sumBuf <= 0;
                expBuf <= 0;
                done <= 1;
                NS <= 4;
            end
            else begin
                if(sumBuf[5]) begin //fraction overflow case
                    NS <= 3;
                    fracOv <= 1;
                end
                else begin //no fraction overflow
                    NS <= 3;
                    fracOv <= 0;
                end
            end
        end
        3: begin    //normalize fractions
            done <= 0;
            if(sumBuf[5]==sumBuf[4]) begin //need normalization
                needNorm <= 1;
                NS <= 3;
            end
            else begin
                needNorm <= 0;
                NS <= 4;
            end
        end
        4: begin    //exponent overflow check
            if(expBuf + 4 > 7) begin //if exp > 3'b111, overflow 
                expOv <= 1;
                done <= 1;
            end
            else begin
                expOv <= 0;
                done <= 1;
            end
        end
    endcase
end

always @(posedge CLK) begin
    CS <= NS;
    if (LoadRegs) begin
        AFrac <= {1'b1, A[3:0]};
        BFrac <= {1'b1, B[3:0]};
        AExp <= A[6:4] - 4; //exp offset = 4
        BExp <= B[6:4] - 4;
    end
    if (expNoEq) begin
        if(BExp < AExp) begin
            BExp <= BExp + 1;
            BFrac <= BFrac >> 1;
        end
        else begin
            AExp <= AExp + 1;
            AFrac <= AFrac >> 1;
        end
    end
    if (fracOv) begin
       sumBuf <= sumBuf >> 1;
       expBuf <= expBuf + 1;
    end  
    if (needNorm) begin
        sumBuf <= sumBuf << 1;
        expBuf <= expBuf - 1;
    end
    if(done) begin
        Sum <= {sumBuf[5], expBuf[2:0], sumBuf[3:0]};
    end
end

endmodule
