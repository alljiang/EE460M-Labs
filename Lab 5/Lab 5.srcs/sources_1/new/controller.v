`timescale 1ns / 1ps
module controller(clk, cs, we, address, data_in, data_out, btns, swtchs, leds, segs,an);

    input clk;
    output reg cs = 1;  //enables write command as well
    output reg we = 0;  //write enable
    output reg [6:0] address = 7'h7F;
    input[7:0] data_in;
    output reg [7:0] data_out = 0;
    input[3:0] btns;
    input[7:0] swtchs;
    output reg [7:0] leds = 0;
    output[6:0] segs;
    output[3:0] an;
    
    //WRITE THE FUNCTION OF THE CONTROLLER
    
    wire pop, push, subtract, add, clear, top, dec_addr, inc_addr;
    
    reg [6:0] DAR = 0;  //  display address register
    reg [7:0] DVR = 0;  //  display value register
    
    reg nextCycle_write = 0;
    reg nextCycle_endWrite = 0;
    
    reg adding = 0;
    reg subtracting = 0;
    integer subtractingState = 0;
    
    always @(posedge clk) begin
        if(nextCycle_write) begin
            nextCycle_write = 0;
            nextCycle_endWrite = 1;
        end
        else if(nextCycle_endWrite) begin
            we = 0;
            address = address - 1;
        end
        else if(adding) begin
        end
        else if(subtracting) begin
        end
        else begin
            if(pop) begin
                if(address < 7'h7F) begin
                    address = address + 1;
                end 
            end
            else if(push) begin
                if(address > 0) begin
                    nextCycle_write = 1;
                    data_out = swtchs;
                end
            end
            else if(subtract) begin
                subtracting = 1;
            end 
            else if(add) begin
                adding = 1;
            end
            else if(clear) begin
            end
            else if(top) begin
            end
            else if(dec_addr) begin
            end
            else if(inc_addr) begin
            end
        end
    end
    
endmodule