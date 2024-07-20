module top_module (
	input [7:0] in,
	output [7:0] out
);

	assign out = in[7:0]; // simply reversing the bit order using concatenation

endmodule
