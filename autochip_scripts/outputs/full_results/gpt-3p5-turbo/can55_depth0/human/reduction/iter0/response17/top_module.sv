module top_module (
	input [7:0] in,
	output parity
);

wire [8:0] in_with_parity;
assign in_with_parity[7:0] = in;
assign in_with_parity[8] = ^in;

assign parity = in_with_parity[8];

endmodule
