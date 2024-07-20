module top_module (
	input [7:0] in,
	output parity
);

wire [7:0] xor_out;
assign xor_out = ^in;

assign parity = xor_out;

endmodule
