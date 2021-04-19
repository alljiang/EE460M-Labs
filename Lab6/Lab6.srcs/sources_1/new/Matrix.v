`timescale 1ns / 1ps

module Matrix(

    input clk,
    input a00, a01, a02, a10, a11, a12, a20, a21, a22,
    input b00, b01, b02, b10, b11, b12, b20, b21, b22,
    output reg matrixComplete = 0,
    output aOut, bOut, cOut, dOut, eOut, fOut, gOut, hOut, iOut

    );
    
    reg[7:0] topleftInput = 0, topmidInput = 0, toprightInput = 0;
    reg[7:0] lefttopInput = 0, leftmidInput = 0, leftbottomInput = 0;
    reg start = 0;
    
    wire[7:0] a_b, a_c, b_b, b_c, c_c, d_b, d_c, e_b, e_c, f_c, g_b, h_b;
    
    reg[3:0] cycleCount = 0;
    
    /*  
        a b c       b output is horizontal
        d e f       c output is vertical
        g h i
    */
    
    MAC topleft(clk, lefttopInput, topleftInput, start, aOut, a_b, a_c);
    MAC topmid(clk, a_b, topmidInput, start, bOut, b_b, b_c);
    MAC topright(clk, b_b, toprightInput, start, cOut, , c_c);
    MAC midleft(clk, leftmidInput, a_c, start, dOut, d_b, d_c);
    MAC midmid(clk, d_b, b_c, start, eOut, e_b, e_c);
    MAC midright(clk, e_b, c_c, start, fOut, , f_c);
    MAC botleft(clk, leftbottomInput, d_c, start, gOut, g_b, );
    MAC botmid(clk, g_b, e_c, start, hOut, h_b, );
    MAC botright(clk, h_b, f_c, start, iOut, , );
    
    always @(posedge clk) begin
        if(cycleCount == 8) matrixComplete = 1;
        else if(!start && cycleCount != 0) start = 1;
        else begin
            start = 0;
            //  all MACs are finished, send in new values
            cycleCount = cycleCount + 1;
            if(cycleCount == 1) begin
                topleftInput = b00; topmidInput = 0; toprightInput = 0;
                lefttopInput = a00; leftmidInput = 0; leftbottomInput = 0;
            end
            else if(cycleCount == 2) begin
                topleftInput = b10; topmidInput = b01; toprightInput = 0;
                lefttopInput = a01; leftmidInput = a10; leftbottomInput = 0;
            end
            else if(cycleCount == 3) begin
                topleftInput = b20; topmidInput = b11; toprightInput = b02;
                lefttopInput = a02; leftmidInput = a11; leftbottomInput = a20;
            end
            else if(cycleCount == 4) begin
                topleftInput = 0; topmidInput = b21; toprightInput = b12;
                lefttopInput = 0; leftmidInput = a12; leftbottomInput = a21;
            end
            else if(cycleCount == 5) begin
                topleftInput = 0; topmidInput = 0; toprightInput = b22;
                lefttopInput = 0; leftmidInput = 0; leftbottomInput = a22;
            end
            else if(cycleCount == 6) begin
                topleftInput = 0; topmidInput = 0; toprightInput = 0;
                lefttopInput = 0; leftmidInput = 0; leftbottomInput = 0;
            end
            else if(cycleCount == 7) begin
                topleftInput = 0; topmidInput = 0; toprightInput = 0;
                lefttopInput = 0; leftmidInput = 0; leftbottomInput = 0;
            end     
        end
        else start = 0;
    end
    
endmodule