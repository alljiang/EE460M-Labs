module MIPS_TestbenchB();
  reg CLK;
  reg RST;
  wire CS;
  wire WE;
  wire [31:0] Mem_Bus;
  wire [6:0] Address;
  reg [2:0] R1_CTRL;
  wire [31:0] R2OUT;
  wire [7:0] OUT;
  reg TestB;

  reg init;
  reg WE_TB, CS_TB;
  wire WE_mem, CS_mem;
  reg [6:0] Address_TB;
  wire [6:0] Address_mem;

  parameter N = 600;
  
  initial
  begin
    CLK = 0;
  end

    assign Address_mem = (init) ? Address_TB : Address;
    assign WE_mem = (init) ? WE_TB : WE;
    assign CS_mem = (init) ? CS_TB : CS;

  MIPSB CPU(CLK, RST, CS, WE, Address, Mem_Bus, OUT, R1_CTRL, TestB, R2OUT);
  Memory MEM(CS_mem, WE_mem, CLK, Address_mem, Mem_Bus);

  always
  begin
    #5 CLK = !CLK;
  end

  initial begin
	CLK = 0;
	R1_CTRL = 0;
	TestB = 1;
  end

  integer i;
  always
  begin
    RST <= 1'b1; //reset the processor
    @(posedge CLK)
	init <= 1; WE_TB <= 1; CS_TB <= 1;
    //Notice that the memory is initialize in the memory module not here

    @(posedge CLK) 
	init <= 0; WE_TB <= 0; CS_TB <= 0;

    @(posedge CLK);
    RST = 1'b0; 
	// driving reset low here puts processor in normal operating mode


    for(i=1; i<= N; i = i+1) begin
	@(posedge CLK)begin
	   if(i%100 == 0) R1_CTRL = R1_CTRL + 1;
	end
    end
    /* add your testing code here */
    // you can add in a 'Halt' signal here as well to test Halt operation
    // you will be verifying your program operation using the
    // waveform viewer and/or self-checking operations

    $display("TEST COMPLETE");
    $stop;
  end

endmodule


