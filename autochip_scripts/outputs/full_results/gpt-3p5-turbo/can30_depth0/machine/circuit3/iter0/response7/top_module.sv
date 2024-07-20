module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Intermediate signals for bitwise OR operations
	wire ab_or, cd_or;

	// Intermediate signal for final bitwise AND operation
	reg q_reg;

	// Bitwise OR gates
	assign ab_or = a | b;
	assign cd_or = c | d;

	// Bitwise AND gate
	always @ (*) begin
		q_reg = ab_or & cd_or;
	end

	// Output assignment
	assign q = q_reg;

endmodule
