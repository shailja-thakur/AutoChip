module top_module (
	input [7:0] in,
	output parity
);
    assign parity = ^in;  // The ^ operator computes the XOR of all bits in 'in'
endmodule
