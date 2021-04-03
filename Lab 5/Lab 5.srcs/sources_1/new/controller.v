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
    Decode_Input DI(clk, btns, pop, push, subtract,add, clear, top, dec_addr, inc_addr);
    
    reg [6:0] DAR = 0;  //  display address register
    reg [7:0] DVR = 0;  //  display value registerZ
    
    reg nextCycle_startWrite = 0;
    reg nextCycle_write = 0;
    reg nextCycle_endWrite = 0;
    
    reg adding = 0;
    integer addingState = 0;
    reg subtracting = 0;
    integer subtractingState = 0;
    
    integer operand1 = 0;
    integer operand2 = 0;
    
    always @(posedge clk) begin
        if(nextCycle_startWrite) begin
            nextCycle_startWrite = 0;
            nextCycle_write = 1;
            we = 1;
        end
        if(nextCycle_write) begin
            nextCycle_write = 0;
            nextCycle_endWrite = 1;
        end
        else if(nextCycle_endWrite) begin
            we = 0;
            address = address - 1;
            nextCycle_endWrite = 0;
        end
        else if(adding) begin
            if(addingState == 0) begin
                addingState = 1;
                operand1 = data_in;
                address = address + 1;
            end
            else if(addingState == 1) begin
                addingState = 2;
                operand2 = data_in;
            end
            else if(addingState == 2) begin
                addingState = 3;
                data_out = operand2 + operand1;
                nextCycle_startWrite = 1;
            end
        end
        else if(subtracting) begin
            if(subtractingState == 0) begin
                subtractingState = 1;
                operand1 = data_in;
                address = address + 1;
            end
            else if(subtractingState == 1) begin
                subtractingState = 2;
                operand2 = data_in;
            end
            else if(subtractingState == 2) begin
                subtractingState = 0;
                data_out = operand2 - operand1;
                nextCycle_startWrite = 1;
            end
        end
        else begin
            if(pop) begin
                if(address < 7'h7F) begin
                    address = address + 1;
                end 
            end
            else if(push) begin
                if(address > 0) begin
                    nextCycle_startWrite = 1;
                    data_out = swtchs;
                end
            end
            else if(subtract) begin
                if(address <= 7'hFD) begin
                    subtracting = 1;
                    subtractingState = 0;
                    address = address + 1;  //  start pop 
                end
            end 
            else if(add) begin
                if(address <= 7'hFD) begin
                    adding = 1;
                    addingState = 0;
                    address = address + 1;  //  start pop 
                end
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