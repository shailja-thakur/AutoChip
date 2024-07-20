module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Wire to compute the sum
	wire [8:0] sum;

	// Wire to compute the overflow
	wire v;

	// Instantiate the adder module
	adder adder_inst (
		.A(a),
		.B(b),
		.S(sum),
		.V(v)
	);

	// Assign the sum output
	assign s = sum[7:0];

	// Assign the overflow output
	assign overflow = v;

endmodule
module adder (
	input [7:0] A,
	input [7:0] B,
	output [8:0] S,
	output V
);
	
	// Add the two input numbers
	assign S = A + B;

	// Check for overflow
	assign V = (A[7] == B[7]) && (A[7] != S[7]);

endmodule
