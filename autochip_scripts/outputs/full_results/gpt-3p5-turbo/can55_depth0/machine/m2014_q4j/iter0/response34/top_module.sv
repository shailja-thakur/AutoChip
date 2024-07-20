module top_module (
    input [3:0] x,
    input [3:0] y,
    output [4:0] sum
);

	// Internal signal to store the carry bit
	reg c;

	// Assign the LSB of the sum as the XOR of the LSBs of x, y, and carry
	assign sum[0] = x[0] ^ y[0] ^ c;

	// Generate the carry for the second bit of sum
	assign c = (x[0] & y[0]) | (x[0] & c) | (y[0] & c);

	// Assign the remaining bits of sum as the XOR of the corresponding bits of x, y, and carry
	assign sum[1] = x[1] ^ y[1] ^ c;
	assign sum[2] = x[2] ^ y[2] ^ c;
	assign sum[3] = x[3] ^ y[3] ^ c;
	assign sum[4] = c;

endmodule
