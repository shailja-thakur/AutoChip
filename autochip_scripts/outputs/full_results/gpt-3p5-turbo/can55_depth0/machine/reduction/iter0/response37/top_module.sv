module top_module (
	input [7:0] in,
	output parity
);

// Parity checker logic
reg parity;

// Assigning the output port to the bitwise XOR of the 8-bit input
assign parity = ^in;

endmodule
