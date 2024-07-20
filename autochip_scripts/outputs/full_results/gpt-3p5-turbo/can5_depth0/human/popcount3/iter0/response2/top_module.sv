module top_module (
	input [2:0] in,
	output [1:0] out
);

	// instantiate population count circuit
	population_count count(
		.in(in),
		.out(out)
	);

endmodule
module population_count (
	input [2:0] in,
	output [1:0] out
);

	// wire declarations
	wire [2:0] intermediate1;
	wire [1:0] intermediate2;

	// intermediate wires for counting
	assign intermediate1[2] = in[2];
	assign intermediate1[1] = intermediate1[2] | in[1];
	assign intermediate1[0] = intermediate1[1] | in[0];

	// intermediate wires for output
	assign intermediate2[1] = intermediate1[2] & intermediate1[1];
	assign intermediate2[0] = intermediate1[1] & intermediate1[0];

	// assign output
	assign out = intermediate2;

endmodule
