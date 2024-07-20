module top_module (
	input clk,
	input x,
	output z
);

	// Internal signals for D flip-flops outputs
	reg q1, q2, q3;
	wire d1, d2, d3;
	wire nq1, nq2, nq3;

	// Generate complemeted outputs for AND and OR gates
	assign nq1 = ~q1;
	assign nq2 = ~q2;
	assign nq3 = ~q3;

	// Generate D inputs for flip-flops
	assign d1 = x ^ q1;
	assign d2 = x & nq2;
	assign d3 = x | nq3;

	// D flip-flops
	always @(posedge clk) begin
		q1 <= d1;
		q2 <= d2;
		q3 <= d3;
	end

	// XNOR gate to produce output z
	assign z = ~(q1 ^ q2 ^ q3);

endmodule
