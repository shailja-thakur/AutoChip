module top_module (
	input [2:0] in,
	output [1:0] out
);

	// Declare intermediate wires
	wire [1:0] count;

	// Instantiate the population count circuit
	population_count pop_count (
		.in(in),
		.out(count)
	);

	// Output the count
	assign out = count;

endmodule
module population_count (
	input [2:0] in,
	output [1:0] out
);
	// Declare intermediate wires
	wire [1:0] count;

	// Compute the count
	assign count = in[0] + in[1] + in[2];

	// Output the count
	assign out = count;

endmodule
