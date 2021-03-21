`timescale 1ns / 1ps
`define clkDiv (10*000001)

module FitBit(
    input CLK, rst, start,
    input [1:0] MD,
    output reg si = 0,
    output [3:0]an,
    output [6:0]seg,
    output dp,
    output debug,
    output debug2
);

reg needDP = 0;
wire pulse;
PulseGenerator generator(CLK, start, MD[1:0], pulse, debug2);

reg [15:0]disp; //display register 
sevenseg display(CLK, disp[15:0], rst, none, an[3:0], seg[6:0], needDP, dp);

wire [15:0]secondsFastPace;
SpeedwalkTime over32(CLK, rst, pulse, secondsFastPace);

wire [15:0] hiActiv;
HighActivity hi(CLK, rst, pulse, hiActiv);

assign debug = pulse;

//step count generator
reg [31:0] count = 0; //total steps  
always @(posedge pulse)
begin
    if(rst) begin
        count <= 0;
    end
    else count <= count+1;
end

//delay for 2s
time delay = 0;
reg [2:0]delayFlag = 0;
reg changeDisp = 0;
always @(posedge CLK) 
begin
    if(rst) delayFlag = 0;

    if(delay < (2000000000/`clkDiv)-1) begin
    //2000000000-1
        delay <= delay+1;
        changeDisp <= 0;
    end
    else begin //delay > 2mil
        delay <= 0;
        changeDisp <= 1;
        if(delayFlag < 3) begin
            delayFlag = delayFlag+1;
        end
        else  begin//delayFlag >= 3
            delayFlag =0;
        end
    end
end

//fixed point milage
reg [15:0] fixedM = 0; //fixed point rep of distance covered
always @(posedge CLK) begin
    fixedM <= count / 2048 * 5; 
end


//delay handler changes display mode
//period of 2s each
//Total step count, Distance covered, Steps over 32(time)
//High activity time, Total step count, Distance covered...and so on
always @(posedge CLK)
begin
    if(rst) begin
        si = 0;
        disp <= 9999;
    end
//    else if(delayFlag == 0)begin
//        if(count > 9999) begin
//            disp <= 9999;
//            si = 1;
//        end
//        else begin
//            disp <= count;
//        end 
//        needDP <= 0;
//    end
//    else if(delayFlag == 1)begin
//        disp <= fixedM; 
//        needDP <= 1;
//    end
//    else if(delayFlag == 2)begin
//        disp <= secondsFastPace; //output of speedWalkTime
//        needDP <= 0;
//    end
//    else if(delayFlag == 3)begin
//        disp <= hiActiv;
//        needDP <= 0;
//    end
//    else begin//should not happen
//        disp <= disp; 
//    end

    disp <= secondsFastPace;
//    disp <= hiActiv;
    needDP <= 0;

end

endmodule
