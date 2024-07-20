module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
	// Create intermediate wire for sum
	wire [7:0] sum;
	
	// Assign sum as the addition of the two inputs
	assign sum = a + b;
	
	// Assign the 8 least significant bits of sum to the output s
	assign s = sum[7:0];
	
	// Assign overflow based on logical expression
	assign overflow = (a[7] == b[7]) && (sum[7] != a[7]);
endmodule
