module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

wire [8:0] sum;  // Add an additional bit to store the carry

assign sum = a + b; // Calculate the sum of a and b

assign s = sum[7:0]; // Take the 8 least significant bits of the sum as the output s

assign overflow = (a[7] == b[7]) && (a[7] != sum[7]); // Check for overflow condition

endmodule
