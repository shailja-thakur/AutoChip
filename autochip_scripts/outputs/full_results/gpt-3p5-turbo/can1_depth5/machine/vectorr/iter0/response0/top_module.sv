module top_module (
	input [7:0] in,
	output [7:0] out
);
	// Assign the output based on the reverse of the input
	assign out = {in[7], in[6], in[5], in[4], in[3], in[2], in[1], in[0]};
endmodule
