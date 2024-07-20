module top_module (
	input clk,
	input x,
	output z
);

	// Internal signals for flip-flop outputs
	reg q1, q2, q3;
	wire d1, d2, d3;
	wire q1_bar, q2_bar, q3_bar;

	// Complemented outputs of the flip-flops
	assign q1_bar = ~q1;
	assign q2_bar = ~q2;
	assign q3_bar = ~q3;

	// D flip-flop input logic
	assign d1 = x ^ q1;
	assign d2 = x & q2_bar;
	assign d3 = x | q3_bar;

	// D flip-flops
	always @(posedge clk) begin
		q1 <= d1;
		q2 <= d2;
		q3 <= d3;
	end

	// XNOR gate with flip-flop outputs
	assign z = ~(q1 ^ q2 ^ q3);

endmodule
