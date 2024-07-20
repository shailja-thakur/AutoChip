module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);
	// Define internal wire and register
	wire c;
	reg q_reg, state_reg;

	// Register logic
	always @(posedge clk)
	begin
		c <= (a & b) | (a & c) | (b & c);
	end

	// Output logic
	always @(posedge clk or a or b or c)
	begin
		q_reg <= a ^ b ^ c;
		state_reg <= c;
	end

	// Assign outputs
	assign q = q_reg;
	assign state = state_reg;

endmodule
