module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// Perform bitwise AND operation between the two input signals
	assign out_both = in[99:1] & in[98:0];

	// Perform bitwise OR operation between the two input signals
	assign out_any = in | {in[99], in[98:0]};

	// Perform bitwise XOR operation between the two input signals
	assign out_different = in ^ {in[0], in[99:1]};

endmodule
