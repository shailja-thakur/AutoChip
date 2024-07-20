module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Create internal signals
	wire s1, s2, c1, c2;

	// Create instances of half adders
	half_adder HA1 (.a(a), .b(b), .sum(s1), .carry(c1));
	half_adder HA2 (.a(s1), .b(cin), .sum(sum), .carry(c2));

	// Create instances of OR and AND gates
	or_gate OR1 (.a(c1), .b(c2), .cout(cout));

endmodule
