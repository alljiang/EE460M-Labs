///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

module Memory(CS, WE, CLK, ADDR, Mem_Bus);
    input CS;
    input WE;
    input CLK;
    input [6:0] ADDR;
    inout [31:0] Mem_Bus;

    reg [31:0] data_out;
    reg [31:0] RAM [0:127];
    integer i;
    
    initial begin
        for ( i = 0; i < 128; i = i+1 ) 
            RAM[i] = 32'd0;
        
        //$readmemh("TestA_Cases_Book.txt", RAM); 
	//$readmemb("TestA_LoopShift.txt", RAM);
	$readmemb("TestB_GivenTest.txt", RAM);
        
        for ( i = 0; i < 128; i = i+1 ) 
            $display("%h", RAM[i]);
    end
    
    assign Mem_Bus = ((CS == 1'b0) || (WE == 1'b1)) ? 32'bZ : data_out;
    
    always @(negedge CLK) begin
        if((CS == 1'b1) && (WE == 1'b1))
            RAM[ADDR] <= Mem_Bus[31:0];
        data_out <= RAM[ADDR];
    end
endmodule
