module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);

  reg [1:0] q_reg;
  reg [1:0] state_reg;
  
  always @(posedge clk) begin
    state_reg <= a & b;
    q_reg <= state_reg[1];
  end
  
  assign q = q_reg[1];
  assign state = state_reg[1];
  
endmodule
