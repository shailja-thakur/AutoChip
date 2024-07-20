module top_module(
	input wire x,
	input wire y,
	output wire z);

	// Gate 1
	wire gate1_out;
	assign gate1_out = x & ~y;

	// Gate 2
	wire gate2_out;
	assign gate2_out = ~x & y;

	// Gate 3
	wire gate3_out;
	assign gate3_out = gate1_out | gate2_out;

	// Output assignment
	assign z = gate3_out;
endmodule
