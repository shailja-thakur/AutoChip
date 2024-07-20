module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
	wire [7:0] sum;
	// Adding the two inputs
	assign sum = a + b;
	// Assigning the 8 least significant bits of the sum to the output
	assign s = sum[7:0];
	// Checking for overflow condition
	assign overflow = (a[7] == b[7]) && (a[7] != s[7]);
endmodule
