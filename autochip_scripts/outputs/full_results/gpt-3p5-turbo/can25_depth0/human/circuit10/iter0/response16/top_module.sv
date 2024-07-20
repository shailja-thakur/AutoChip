module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);
	// Declare flip-flop
	reg q_reg;
	
	// Declare state variable
	reg state_reg;
	
	// Declare combinational logic
	assign state = state_reg;
	assign q = q_reg;
	
	// Flip-flop behavior
	always @(posedge clk) begin
		q_reg <= a & ~b;
		state_reg <= q_reg | (a & b);
	end
endmodule
