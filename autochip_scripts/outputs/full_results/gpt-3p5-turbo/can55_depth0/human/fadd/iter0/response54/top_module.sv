module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Internal signals
	wire s1, s2, s3;

	// First stage full adder
	full_adder FA1(.a(a), .b(b), .cin(cin), .cout(s1), .sum(s2));

	// Second stage full adder
	full_adder FA2(.a(s2), .b(s1), .cin(1'b0), .cout(s3), .sum(sum));

	// Output signals
	assign cout = s3;

endmodule
