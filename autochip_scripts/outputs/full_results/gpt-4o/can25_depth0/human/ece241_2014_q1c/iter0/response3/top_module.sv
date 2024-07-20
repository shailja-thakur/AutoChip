module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Intermediate wire for carrying sum including the carry-out bit
	wire [8:0] sum_extended;
	
	// Compute the sum with an extra bit for overflow detection
	assign sum_extended = {a[7], a} + {b[7], b};
	
	// Extract the 8-bit sum
	assign s = sum_extended[7:0];
	
	// Overflow occurs if the carry into the sign bit and the carry out of the sign bit differ
	assign overflow = sum_extended[8] ^ sum_extended[7];

endmodule
