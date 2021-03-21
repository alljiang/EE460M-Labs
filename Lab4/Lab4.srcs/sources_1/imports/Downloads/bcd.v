`timescale 1ns / 1ps

module bcd(
    input [3:0] sw ,
    input overflow,
    output [6:0] seg
    );
    
    reg [6:0] sseg = 0; assign seg = sseg;
    
    always @(*) begin
        if(overflow)
            sseg = 7'b0111_111;
        else begin
            case(sw)
            4'b0000: sseg = 7'b1000_000;
            4'b0001: sseg = 7'b1111_001;
            4'b0010: sseg = 7'b0100_100;
            4'b0011: sseg = 7'b0110_000;
            4'b0100: sseg = 7'b0011_001;
            4'b0101: sseg = 7'b0010_010;
            4'b0110: sseg = 7'b0000_010;
            4'b0111: sseg = 7'b1111_000;
            4'b1000: sseg = 7'b0000_000;
            4'b1001: sseg = 7'b0010_000;
            4'b1010: sseg = 7'b0001_000;
            4'b1011: sseg = 7'b0000_011;
            4'b1100: sseg = 7'b1000_110;
            4'b1101: sseg = 7'b0100_001;
            4'b1110: sseg = 7'b0000_110;
            4'b1111: sseg = 7'b0001_110;
            default: sseg = 7'b1111111;
            endcase
        end 
    end
    
endmodule
