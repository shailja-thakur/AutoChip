module top_module (
	input clk,
	input x,
	output z
);

	reg q1, q2, q3;
	wire d1, d2, d3;
	wire nq1, nq2, nq3;

	// Intermediate signals
	assign nq1 = ~q1;
	assign nq2 = ~q2;
	assign nq3 = ~q3;

	assign d1 = x ^ q1;
	assign d2 = x & nq2;
	assign d3 = x | nq3;

	// Flip-flops
	always @(posedge clk) begin
		q1 <= d1;
		q2 <= d2;
		q3 <= d3;
	end

	// Output logic
	assign z = ~(q1 ^ q2 ^ q3);

endmodule
