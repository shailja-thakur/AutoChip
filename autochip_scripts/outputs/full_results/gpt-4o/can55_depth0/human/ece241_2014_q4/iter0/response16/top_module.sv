module top_module (
	input clk,
	input x,
	output z
);

	wire xor_in;
	wire and_in;
	wire or_in;
	wire q1, q2, q3;
	wire nq1, nq2, nq3;

	// Flip-flops
	dff dff1 (
		.clk(clk),
		.d(xor_in),
		.q(q1),
		.nq(nq1)
	);

	dff dff2 (
		.clk(clk),
		.d(and_in),
		.q(q2),
		.nq(nq2)
	);

	dff dff3 (
		.clk(clk),
		.d(or_in),
		.q(q3),
		.nq(nq3)
	);

	// Logic gates
	assign xor_in = x ^ q1;
	assign and_in = x & nq2;
	assign or_in  = x | nq3;

	// XNOR gate for final output
	assign z = ~(q1 ^ q2 ^ q3);

endmodule
module dff (
	input clk,
	input d,
	output reg q,
	output nq
);

	always @(posedge clk) begin
		q <= d;
	end

	assign nq = ~q;

endmodule
