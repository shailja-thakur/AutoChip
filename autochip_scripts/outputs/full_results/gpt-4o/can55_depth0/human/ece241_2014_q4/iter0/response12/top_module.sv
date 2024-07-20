module top_module (
	input clk,
	input x,
	output z
);

	// Internal flip-flop outputs
	reg q1, q2, q3;

	// Inputs to FFs are connected to the respective gates
	wire d1, d2, d3;

	// Intermediate signals
	wire q2_n, q3_n;

	// D Flip-Flop connections to logic gates
	assign d1 = x ^ q1;
	assign d2 = x & ~q2;
	assign d3 = x | ~q3;

	// D flip-flops with synchronous reset
	always @(posedge clk) begin
		q1 <= d1;
		q2 <= d2;
		q3 <= d3;
	end

	// Inverter outputs (complementary outputs)
	assign q2_n = ~q2;
	assign q3_n = ~q3;

	// Three-input XNOR gate
	assign z = ~(q1 ^ q2 ^ q3);

endmodule
