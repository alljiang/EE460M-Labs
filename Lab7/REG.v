///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

module REG(CLK, RegW, DR, SR1, SR2, Reg_In, ReadReg1, ReadReg2, OUT, R1_CTRL, TestB, R2OUT);
  input CLK;
  input RegW;
  input [4:0] DR;
  input [4:0] SR1;
  input [4:0] SR2;
  input [31:0] Reg_In;
  output reg [31:0] ReadReg1;
  output reg [31:0] ReadReg2;
  output [31:0] R2OUT;
  output [7:0] OUT;
  input [2:0] R1_CTRL;
  input TestB;

  reg [31:0] REG [0:31];
  integer i;

  initial begin
    ReadReg1 = 0;
    ReadReg2 = 0;
  end

  always @(posedge CLK)
  begin
    if(RegW == 1'b1)
      REG[DR] <= Reg_In[31:0];
    if(TestB)
	REG[1] <= R1_CTRL;

    ReadReg1 <= REG[SR1];
    ReadReg2 <= REG[SR2];
  end

assign OUT = REG[1][7:0]; 
assign R2OUT = REG[2][31:0];

endmodule

