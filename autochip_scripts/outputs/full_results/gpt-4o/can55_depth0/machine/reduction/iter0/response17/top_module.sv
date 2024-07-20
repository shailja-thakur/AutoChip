module top_module (
	input [7:0] in,
	output parity
);
    
    // Assign parity to the bitwise XOR of all bits in the input
    assign parity = ^in;

endmodule
