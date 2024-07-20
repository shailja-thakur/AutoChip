module top_module (
	input [7:0] in,
	output wire parity
);
	assign parity = ^in;
endmodule
