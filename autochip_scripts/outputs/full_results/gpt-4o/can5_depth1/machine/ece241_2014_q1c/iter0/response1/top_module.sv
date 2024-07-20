module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	wire [8:0] sum; // Increase the width to 9 bits to handle overflow

	assign sum = {1'b0, a} + {1'b0, b}; // Perform the addition, extend inputs to 9 bits
	assign s = sum[7:0]; // Assign the lower 8 bits to s
	assign overflow = (a[7] == b[7]) && (s[7] != a[7]); // Check for overflow condition

endmodule
