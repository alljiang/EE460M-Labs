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
                AExp <= A[6:4];
                BExp <= B[6:4];
            end
            else NS <= 0;
        end
        1: begin
            done <= 0;
            prodBuf = AFrac * BFrac;
            expBuf = AExp + BExp;
            
            if(prodBuf == 0) begin  //product is 0, special case
                expBuf <= 4'b0100; //set as most negative 3b fraction (leave overflow detector bit 0)
                NS <= 2;
            end
            else begin
                if(prodBuf[9:5] > 0) begin
                    ov <= 1;    //fraction overflow, signal to shift right
                    NS <= 1;    //stay in same state until fraction no overflow
                end
                else begin
                    ov <= 0;
                    NS <= 2;
                end
            end
        end
        2: begin
            done <= 1;
            if(expBuf[3] == 1) begin    //overflow detection in exponent
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
    if(ov) begin
        prodBuf <= prodBuf >> 1;
        expBuf <= expBuf + 1;
    end
end

endmodule