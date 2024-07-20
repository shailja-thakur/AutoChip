module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
	// Intermediate wire to hold the 9-bit sum of a and b
	wire [8:0] sum;
	
	// Perform the addition
	assign sum = a + b;
	
	// Assign the 8 least significant bits to the output s
	assign s = sum[7:0];
	
	// Determine if there's an overflow
	assign overflow = (a[7] == b[7]) && (s[7] != a[7]);
	
endmodule
