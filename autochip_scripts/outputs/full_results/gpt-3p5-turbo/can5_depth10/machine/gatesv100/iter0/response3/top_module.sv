module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

  // Declare internal wires
	wire [99:0] shifted_in;

  // Assign shifted_in as the input signal shifted by one bit
	assign shifted_in = {in[98:0], in[99]};

  // Perform bit-wise AND operation between the two input signals to generate out_both
	assign out_both = in[0:98] & shifted_in;

  // Perform bit-wise OR operation between the two input signals to generate out_any
	assign out_any = in | shifted_in;

  // Perform bit-wise XOR operation between the two input signals to generate out_different
	assign out_different = {in[0] ^ shifted_in[99], in[1:99] ^ shifted_in[98:0]};
  
endmodule
