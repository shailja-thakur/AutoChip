module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Internal signals
	wire s1, s2, c1, c2;

	// Instantiate the full adder
	full_adder fa1(a, b, cin, s1, c1);
	full_adder fa2(s1, cin, s2, sum, c2);

	// Assign the carry-out signal
	assign cout = c1 | c2;

	// Define the full adder module
	module full_adder (
		input a,
		input b,
		input cin,
		output sum,
		output cout
	);
		// Internal signals
		wire s, c1, c2;

		// Implement the logic
		assign s = a ^ b ^ cin;
		assign cout = (a & b) | (a & cin) | (b & cin);

		// Assign the outputs
		assign sum = s;
		assign cout = c2;
	endmodule
