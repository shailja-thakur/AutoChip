module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
	wire [7:0] sum;
	// Add the two inputs a and b
	assign sum = a + b;
	// Assign the 8-bit output s to the 8 least significant bits of sum
	assign s = sum[7:0];
	// Determine the overflow bit
	assign overflow = (a[7] == b[7]) && (a[7] != s[7]);
endmodule
