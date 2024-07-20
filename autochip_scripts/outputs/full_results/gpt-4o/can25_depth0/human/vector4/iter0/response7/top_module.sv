module top_module (
	input [7:0] in,
	output [31:0] out
);

	// Sign extend by replicating bit[7] 24 times and concatenating with the original 8-bit number
	assign out = {{24{in[7]}}, in};

endmodule
