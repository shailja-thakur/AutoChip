module top_module (
	input clk,
	input x,
	output z
);

	// D flip-flop outputs
	reg q1, q2, q3;

	// D flip-flop inputs
	wire d1, d2, d3;

	// Gates output
	wire xor_out, and_out, or_out;

	// Initial state of flip-flops
	initial begin
		q1 = 0;
		q2 = 0;
		q3 = 0;
	end

	// Logic for D flip-flop inputs
	assign d1 = x ^ q1;
	assign d2 = x & ~q2;
	assign d3 = x | ~q3;

	// Flip-flops updated on the clock edge
	always @(posedge clk) begin
		q1 <= d1;
		q2 <= d2;
		q3 <= d3;
	end

	// XNOR gate with flip-flop outputs
	assign z = ~(q1 ^ q2 ^ q3);

endmodule
