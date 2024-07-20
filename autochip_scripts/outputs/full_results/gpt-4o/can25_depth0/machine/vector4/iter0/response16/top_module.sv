module top_module (
	input [7:0] in,
	output [31:0] out
);
	assign out = { {3{in}}, in }; // Replicate the 8-bit input 3 times and concatenate with the original 8-bit input
endmodule
