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
    input CLK,
    input St,
    input [7:0]A,
    input [7:0]B,
    output reg expOv,
    output reg[7:0] prod,
    output reg done
    );

reg [9:0] prodBuf;
reg [3:0] expBuf;
reg ov;
reg norm;
wire sign;
assign sign = A[7]^B[7];

reg [4:0] AFrac;
reg [2:0] AExp;
reg [4:0] BFrac;
reg [2:0] BExp;

reg [1:0] CS;
reg [1:0] NS;

initial begin
    prodBuf = 0;
    expBuf = 0;
    CS = 0;
    NS = 0;
end
    
always @(posedge CLK) begin
    case(CS)
        0: begin
            done <= 0;
            if(St) begin    //load all regs
                NS <= 1;
                AFrac <= {1'b1, A[3:0]};
                BFrac <= {1'b1, B[3:0]};
                AExp <= A[6:4] - 4; //exp offset = 4
                BExp <= B[6:4] - 4;
            end
            else NS <= 0;
        end
        1: begin
            done <= 0;
            prodBuf = AFrac * BFrac;
            expBuf = AExp + BExp + 4;
            
            if(prodBuf == 0) begin  //product is 0, special case
                expBuf <= 4'b0000; //set exp as 0 for special case
                NS <= 2;
            end
            else begin
                if(prodBuf[9:6] > 0) begin //bit 5 is implied 1
                    ov <= 1;    //fraction overflow, signal to shift right
                    NS <= 1;    //stay in same state until fraction no overflow
                end
                else begin
                    ov <= 0;
                    NS <= 2;
                end
            end
        end
        2: begin    //normalization
            if( !prodBuf[6] && prodBuf[5]) begin
                norm <= 0;
                NS <= 3;
            end
            else begin  //not normalized, left shift
                norm <= 1;
                NS <= 2;
            end
        end
        3: begin
            done <= 1;
            if(expBuf+4 > 7) begin    //overflow detection in exponent
                expOv <= 1;
                NS <= 0;
            end
            else begin
                expOv = 0;
                NS <= 0;
            end
        end
    endcase
end
    
always @(posedge CLK) begin
    CS <= NS;
    if(ov) begin    //fraction overflow
        prodBuf <= prodBuf >> 1;
        expBuf <= expBuf + 1;
    end
    if(norm) begin  //normalize fraction
        prodBuf <= prodBuf << 1;
        expBuf <= expBuf - 1;
    end
    if(done) begin
        prod = {sign, expBuf[2:0] + 4, prodBuf[4:0]};
    end  
end

endmodule