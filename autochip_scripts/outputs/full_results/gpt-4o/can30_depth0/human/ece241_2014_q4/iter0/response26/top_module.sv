module top_module (
	input clk,
	input x,
	output z
);
	// Internal signals
	wire q1, q2, q3;
	wire d1, d2, d3;
	wire nq1, nq2, nq3;
	wire xnor_out;

	// Flip-flop logic
	DFF dff1 (.clk(clk), .d(d1), .q(q1));
	DFF dff2 (.clk(clk), .d(d2), .q(q2));
	DFF dff3 (.clk(clk), .d(d3), .q(q3));

	assign nq1 = ~q1;
	assign nq2 = ~q2;
	assign nq3 = ~q3;

	// D Flip-flop input calculation
	assign d1 = x ^ q1;  // XOR gate
	assign d2 = x & nq2; // AND gate
	assign d3 = x | nq3; // OR gate

	// XNOR gate for output z
	assign xnor_out = ~(q1 ^ q2 ^ q3);
	assign z = xnor_out;

endmodule
module DFF (
	input clk,
	input d,
	output reg q
);
	always @(posedge clk) begin
		q <= d;
	end
endmodule
