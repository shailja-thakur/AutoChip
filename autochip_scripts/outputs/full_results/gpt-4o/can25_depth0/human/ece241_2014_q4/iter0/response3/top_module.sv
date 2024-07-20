module top_module (
	input clk,
	input x,
	output z
);

	// Signals for the D flip-flops
	reg q1, q2, q3;

	// Intermediate signals for flip-flop inputs
	wire d1, d2, d3;

	// Flip-flop D input assignments
	assign d1 = x ^ q1;
	assign d2 = x & ~q2;
	assign d3 = x | ~q3;

	// Always block to update the flip-flop values on the clock edge
	always @(posedge clk) begin
		q1 <= d1;
		q2 <= d2;
		q3 <= d3;
	end

	// XNOR gate to produce the output Z
	assign z = ~(q1 ^ q2 ^ q3);

endmodule
