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
    
    wire a_b, a_c, b_b, b_c, c_c, d_b, d_c, e_b, e_c, f_c, g_b, h_b;
    wire[8:0] done;
    
    reg[3:0] cycleCount = 0;
    
    /*  
        a b c       b output is horizontal
        d e f       c output is vertical
        g h i
    */
    
    MAC topleft(clk, lefttopInput, topleftInput, start, aOut, a_b, a_c, done[0]);
    MAC topmid(clk, a_b, topmidInput, start, bOut, a_b, a_c, done[1]);
    MAC topright(clk, b_b, toprightInput, start, cOut, a_b, a_c, done[2]);
    MAC midleft(clk, leftmidInput, a_c, start, dOut, a_b, a_c, done[3]);
    MAC midmid(clk, d_b, b_c, start, eOut, a_b, a_c, done[4]);
    MAC midright(clk, e_b, c_c, start, fOut, a_b, a_c, done[5]);
    MAC botleft(clk, leftbottomInput, d_c, start, gOut, a_b, a_c, done[6]);
    MAC botmid(clk, g_b, e_c, start, hOut, a_b, a_c, done[7]);
    MAC botright(clk, i_b, i_c, start, iOut, a_b, a_c, done[8]);
    
    always @(posedge clk) begin
        if(cycleCount == 8) matrixComplete = 1;
        else if(done[8:0] ==  9'b111111111) begin
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
                lefttopInput = b02; leftmidInput = a11; leftbottomInput = a20;
            end
            else if(cycleCount == 4) begin
                topleftInput = 0; topmidInput = b22; toprightInput = b12;
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