module top_module (
	input clk,
	input x,
	output z
);

	// Intermediate signals
	reg q1, q2, q3;
	wire d1, d2, d3;
	wire qb1, qb2, qb3;
	
	// Complementary outputs of the flip-flops
	assign qb1 = ~q1;
	assign qb2 = ~q2;
	assign qb3 = ~q3;

	// D flip-flop input equations
	assign d1 = x ^ q1;
	assign d2 = x & qb2;
	assign d3 = x | qb3;

	// Clocking block
	always @(posedge clk) begin
		q1 <= d1;
		q2 <= d2;
		q3 <= d3;
	end
	
	// Output Z equation
	assign z = ~(q1 ^ q2 ^ q3);

endmodule
