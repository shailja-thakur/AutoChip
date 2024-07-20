module top_module (
	input [7:0] in,
	output [31:0] out
);
	assign out = {24{in}}; // Replicate the 8-bit input 24 times to form the 24 MSBs
	assign out[31:24] = in; // Concatenate with the original 8-bit input for the 8 LSBs
endmodule
