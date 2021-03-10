`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/10/2021 09:50:31 AM
// Design Name: 
// Module Name: over32
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

module over32(
    input CLK,
    input rst, 
    input count, 
    output reg [3:0]numOv32 = 0);

//save previous value as reference
reg [15:0]savePrev = 0;
reg [21:0]oneSecBuf = 0;
//reg checkOver32 = 0;
reg [3:0]secPassed = 0;

//1 second counter, sets flag to check value 
always @(posedge CLK)
begin
    if(oneSecBuf < (50-1))begin
        //1000000000-1 should be the actual delay
        //checkOver32 <= 0;
        oneSecBuf <= oneSecBuf + 1;
    end
    else begin
        secPassed <= secPassed + 1;
        //checkOver32 <= ~checkOver32;
        oneSecBuf <= 0;
    end
end

//check to see if 9 seconds have passed
always @(posedge secPassed)
begin
    if((secPassed > 9) && rst) begin
        secPassed <= 0;
        numOv32 <= 0;
    end
end

reg [5:0]gethereFlag = 0;
always @(secPassed)
begin 
    gethereFlag = gethereFlag + 1;
    //THE FOLLOWING LINE ISN'T WORKING FOR SOME REASON
    //SAVEPREV NEVER UPDATES WITH THE CORRECT COUNT;
    savePrev <= count;
    if(secPassed < 10)
    begin
        if(count - savePrev > 32) begin
            numOv32 <= numOv32 + 1;
        end
    end
    //save last value for comparison
    //savePrev = count;
end

endmodule
