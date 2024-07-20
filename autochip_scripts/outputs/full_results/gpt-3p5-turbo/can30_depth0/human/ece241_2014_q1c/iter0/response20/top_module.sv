module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
	
	// Wire for storing the sum of a and b
	wire [8:0] sum;
	
	// Wire for storing the overflow value
	wire sum_overflow;
	
	// Sign extend a and b to 9 bits
	wire [8:0] a_extended = {a[7], a[7:0]};
	wire [8:0] b_extended = {b[7], b[7:0]};
	
	// Add a_extended and b_extended
	assign sum = a_extended + b_extended;
	
	// Check for overflow
	assign sum_overflow = (sum[8] != sum[7]);
	
	// Assign output signals
	assign s = sum[7:0];
	assign overflow = sum_overflow;
	
endmodule
