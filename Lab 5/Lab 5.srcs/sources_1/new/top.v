`timescale 1ns / 1ps

module top(clk, btns, sw, led, seg, an);

    input clk;
    input[3:0] btns;
    input[7:0] sw;
    output[7:0] led;
    output[6:0] seg;
    output[3:0] an;
    
    //might need to change some of these from wires to regs
    wire cs;
    wire we;
    wire[6:0] addr;
    wire[7:0] data_out_mem;
    wire[7:0] data_out_ctrl;
    wire[7:0] data_bus;
    
    wire[3:0] debounced;
    
    debounce db0(clk, btns[0], debounced[0]);
    debounce db1(clk, btns[1], debounced[1]);
    debounce db2(clk, btns[2], debounced[2]);
    debounce db3(clk, btns[3], debounced[3]);
    
    //CHANGE THESE TWO LINES
    assign data_bus = we ? data_out_ctrl : data_out_mem;    
    
    // we - write enable, cs - chip select, only necessary for multiple memory modules
    controller ctrl(clk, cs, we, addr, data_bus, data_out_ctrl, debounced, sw, led, seg, an);
    memory mem(clk, cs, we, addr, data_bus, data_out_mem);
    
    //add any other functions you need
    //(e.g. debouncing, multiplexing, clock-division, etc)
    
endmodule
