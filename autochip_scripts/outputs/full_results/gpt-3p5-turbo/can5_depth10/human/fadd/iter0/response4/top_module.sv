module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Declare internal wires
	wire s, c1, c2;
	
	// Create instance of half adder for a and b
	half_adder ha1(.a(a), .b(b), .sum(s), .carry(c1));
	
	// Create instance of half adder for s and cin
	half_adder ha2(.a(s), .b(cin), .sum(sum), .carry(c2));
	
	// Calculate cout using c1 and c2
	assign cout = c1 | c2;

endmodule
