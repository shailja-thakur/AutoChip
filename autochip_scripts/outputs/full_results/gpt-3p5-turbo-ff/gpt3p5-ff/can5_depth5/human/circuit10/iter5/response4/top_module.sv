module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);

	reg q_reg, state_reg;
	
	always @(posedge clk)
	begin
		state_reg <= b & state_reg;
		q_reg <= ~a ? q_reg : state_reg;
	end
	
	assign q = q_reg;
	assign state = state_reg;

endmodule
