module top_module (
	input [7:0] in,
	output parity
);

assign parity = ^in; //calculate even parity using XOR
endmodule
