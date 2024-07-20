module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// wire declaration
	wire [8:0] sum; // Declare 9-bit wire for sum to handle overflow

	// assign statements
	assign sum = a + b; // Add the two 8-bit numbers
	assign s = sum[7:0]; // Assign lower 8 bits of sum to output s
	assign overflow = sum[8]; // Assign MSB of sum to output overflow

endmodule
