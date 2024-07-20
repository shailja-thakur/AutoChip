module top_module (
	input clk,
	input x,
	output z
);

	// Declare D flip-flops
	reg q1, q2, q3;

	// Combination logic for D flip-flops
	wire d1, d2, d3;

	// XOR gate
	assign d1 = x ^ q1;

	// AND gate
	assign d2 = x & ~q2;

	// OR gate
	assign d3 = x | ~q3;

	// D flip-flops with asynchronous reset (assumed to reset to 0 initially)
	always @(posedge clk) begin
		q1 <= d1;
		q2 <= d2;
		q3 <= d3;
	end

	// Three-input XNOR gate
	assign z = ~(q1 ^ q2 ^ q3);

endmodule
