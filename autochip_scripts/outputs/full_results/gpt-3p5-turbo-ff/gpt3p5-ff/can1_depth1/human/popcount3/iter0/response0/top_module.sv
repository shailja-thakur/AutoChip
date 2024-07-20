module top_module (
	input [2:0] in,
	output [1:0] out
);

	// Define the internal wire
	wire [1:0] pop_count;

	// Instantiate the population count circuit
	population_count circuit(
		.in(in),
		.out(pop_count)
	);

	// Output assignment
	assign out = pop_count;

endmodule
module population_count (
	input [2:0] in,
	output [1:0] out
);

	// Define the internal wire
	wire [1:0] count;

	// Logic to count the number of '1's in the input vector
	assign count[0] = in[0] ^ in[1] ^ in[2];
	assign count[1] = in[0] & in[1] | in[1] & in[2] | in[0] & in[2];

	// Output assignment
	assign out = count;

endmodule
