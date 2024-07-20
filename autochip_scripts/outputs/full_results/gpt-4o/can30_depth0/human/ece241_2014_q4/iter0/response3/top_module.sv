module top_module (
	input clk,
	input x,
	output z
);

	// Internal signals for D flip-flop outputs
	reg q1, q2, q3;

	// Intermediate signals for combinational logic
	wire d1, d2, d3;

	// Combinational logic for D flip-flop inputs
	assign d1 = x ^ q1;
	assign d2 = x & ~q2;
	assign d3 = x | ~q3;

	// D flip-flops
	always @(posedge clk) begin
		q1 <= d1;
		q2 <= d2;
		q3 <= d3;
	end

	// XNOR gate for the final output
	assign z = ~(q1 ^ q2 ^ q3);

endmodule
