module top_module (
	input in1,
	input in2,
	input in3,
	output wire out
);

wire xnor_out;

assign xnor_out = ~(in1 ^ in2); // Two-input XNOR
assign out = xnor_out ^ in3;    // Two-input XOR with second input 'in3'

endmodule
