module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// Creating a wire for the second input signal shifted by one bit
	wire [99:0] in_shifted;
	assign in_shifted = {in[98:0], in[99]};

	// Generating out_both by performing bit-wise AND operation
	assign out_both = in[98:0] & in_shifted[98:0];

	// Generating out_any by performing bit-wise OR operation
	assign out_any = in | in_shifted;

	// Generating out_different by performing bit-wise XOR operation
	assign out_different = {in[0] ^ in_shifted[99], in[99:1] ^ in_shifted[98:0]};
  
endmodule
