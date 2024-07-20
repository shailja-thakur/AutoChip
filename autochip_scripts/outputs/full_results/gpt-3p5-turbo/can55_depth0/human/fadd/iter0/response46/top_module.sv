module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

// Create internal signals
wire c1, c2;

// Create instance of half adder
half_adder ha1(.a(a), .b(b), .sum(s1), .carry(c1));

// Create instance of half adder
half_adder ha2(.a(s1), .b(cin), .sum(sum), .carry(c2));

// Calculate carry-out
or_gate og1(.a(c1), .b(c2), .out(cout));

endmodule
