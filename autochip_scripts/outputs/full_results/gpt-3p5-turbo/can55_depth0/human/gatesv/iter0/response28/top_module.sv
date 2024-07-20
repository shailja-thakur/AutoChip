module top_module (
	input [3:0] in,
	output [2:0] out_both,
	output [3:1] out_any,
	output [3:0] out_different
);

	// Internal wires
	wire [4:0] extended_in;  // Extended vector of 'in' for bit wrapping

	// Extend 'in' vector for wrapping
	assign extended_in = {in, in[3]};

	// out_both
	assign out_both[0] = extended_in[0] & extended_in[1];
	assign out_both[1] = extended_in[1] & extended_in[2];
	assign out_both[2] = extended_in[2] & extended_in[3];

	// out_any
	assign out_any[1] = extended_in[0] | extended_in[1];
	assign out_any[2] = extended_in[1] | extended_in[2];
	assign out_any[3] = extended_in[2] | extended_in[3];

	// out_different
	assign out_different[0] = (in[0] != in[3]);
	assign out_different[1] = (in[1] != in[0]);
	assign out_different[2] = (in[2] != in[1]);
	assign out_different[3] = (in[3] != in[2]);

endmodule
