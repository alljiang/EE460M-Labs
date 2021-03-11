`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/03/2021 07:50:44 PM
// Design Name: 
// Module Name: FitBit
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
module FitBit(
    input CLK, rst, start,
    input [1:0] MD,
    output si,
    output [3:0]an,
    output [6:0]seg,
    output dp);

reg decimal = 1;
assign dp =  decimal;    

wire pulse; 
PulseGenerator generator(CLK, start, MD[1:0], pulse);

reg [15:0]disp = 0; //display register 
sevenseg display(CLK, disp[15:0], rst, si, an[3:0], seg[6:0]);

wire [15:0]secondsFastPace = 0;
SpeedwalkTime over32(
CLK, rst, pulse, secondsFastPace
);

reg [15:0] hiActiv = 0;
module HighActivity(CLK, rst, pulse, hiActiv);

//step count generator
reg [15:0] count = 0; //total steps  
always @(posedge pulse)
begin
    if(count < 9999)
        count <= count+1;
    else if(count == 9999)
        count <= 0;
    else //should not happen
        count <= 0;
end

//delay for 2s
reg [21:0]delay = 0;
reg [2:0]delayFlag = 0;
reg changeDisp = 0;
always @(posedge CLK) 
begin
    if(delay < 100-1) begin
    //2000000000-1
        delay <= delay+1;
        changeDisp <= 0;
    end
    else begin //delay > 2mil
        delay <= 0;
        changeDisp <= 1;
        if(delayFlag < 3)
            delayFlag <= delayFlag+1;
        else //delayFlag >= 3
            delayFlag <=0;
    end
end

//fixed point milage
reg [15:0] fixedM = 0; //fixed point rep of distance covered
always @(count)
begin
    if(count < 2048)
        fixedM <= 0;
    else if(2048 <= count < 4096)
        fixedM <= 5;
    else if(4096 <= count < 6144)
        fixedM <= 10;
    else if(6144 <= count < 8192)
        fixedM <= 15;
    else //if count >= 8192
        fixedM <= 20; 
end


//delay handler changes display mode
//period of 2s each
//Total step count, Distance covered, Steps over 32(time)
//High activity time, Total step count, Distance covered...and so on
always @(posedge changeDisp)
begin
    if(delayFlag == 0)begin
        disp <= count; 
        decimal <= 1;
    end
    else if(delayFlag == 1)begin
        disp <= fixedM; 
        decimal <= 0;
    end
    else if(delayFlag == 2)begin
        disp <= secondsFastPace; //output of speedWalkTime
        decimal <= 1;
    end
    else if(delayFlag == 3)begin
        disp <= hiActiv;
        decimal <= 1;
    end
    else begin//should not happen
        disp <= disp; 
    end
end


endmodule
