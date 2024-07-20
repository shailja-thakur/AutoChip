module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Wire for temporary sum bits and carry
	wire [8:0] temp_sum;
	wire carry;
	wire a_tilde;

	// Invert a for 2's complement addition
	assign a_tilde = ~a + 1;

	// Perform addition
	assign temp_sum = a_tilde + b;

	// Assign the sum to the output
	assign s = temp_sum[7:0];

	// Check for overflow
	assign overflow = (temp_sum[8] == 1);

endmodule
