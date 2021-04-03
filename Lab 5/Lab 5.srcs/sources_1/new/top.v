`timescale 1ns / 1ps

module top(clk, btns, swtchs, leds, segs, an);

    input clk;
    input[3:0] btns;
    input[7:0] swtchs;
    output[7:0] leds;
    output[6:0] segs;
    output[3:0] an;
    
    //might need to change some of these from wires to regs
    wire cs;
    wire we;
    wire[6:0] addr;
    wire[7:0] data_out_mem;
    wire[7:0] data_out_ctrl;
    wire[7:0] data_bus;
    
    //CHANGE THESE TWO LINES
    assign data_bus = we ? data_out_ctrl : data_out_mem;    
    
    // we - write enable, cs - chip select, only necessary for multiple memory modules
    controller ctrl(clk, cs, we, addr, data_bus, data_out_ctrl,
    btns, swtchs, leds, segs, an);
    memory mem(clk, cs, we, addr, data_bus, data_out_mem);
    
    //add any other functions you need
    //(e.g. debouncing, multiplexing, clock-division, etc)
    
endmodule
