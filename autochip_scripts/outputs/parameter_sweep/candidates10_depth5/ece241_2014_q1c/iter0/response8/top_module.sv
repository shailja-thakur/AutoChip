module top_module (
	input signed [7:0] a,
	input signed [7:0] b,
	output signed [7:0] s,
	output overflow
);

// Temporary variable for storing the result of addition
wire signed [8:0] temp;

// Computing the sum of a and b
assign temp = a + b;

// Assigning the sum to the output signal s
assign s = temp[7:0];

// Checking for overflow
assign overflow = temp[8];

endmodule
