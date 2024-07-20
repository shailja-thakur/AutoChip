module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);
	wire c1, c2, c3, c4;
	wire s0, s1, s2, s3;

	// Instantiate full adders for each bit of x and y

	// Full adder for bit 0
	assign {c1, s0} = x[0] + y[0];

	// Full adder for bit 1
	assign {c2, s1} = x[1] + y[1] + c1;

	// Full adder for bit 2
	assign {c3, s2} = x[2] + y[2] + c2;

	// Full adder for bit 3
	assign {c4, s3} = x[3] + y[3] + c3;

	// Combine the result to form the 5-bit sum
	assign sum = {c4, s3, s2, s1, s0};

endmodule
