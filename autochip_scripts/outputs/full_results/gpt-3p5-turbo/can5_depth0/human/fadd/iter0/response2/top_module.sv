module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);
	// Declare internal wire variables
	wire s1, s2, carry;

	// Instantiate XOR gates
	xor_gate xor1(.a(a), .b(b), .z(s1));
	xor_gate xor2(.a(s1), .b(cin), .z(sum));

	// Instantiate AND gates
	and_gate and1(.a(a), .b(b), .z(s2));
	and_gate and2(.a(a), .b(cin), .z(carry_in));
	and_gate and3(.a(b), .b(cin), .z(carry_in));
	and_gate and4(.a(s1), .b(cin), .z(carry_out));

	// Instantiate OR gate
	or_gate or1(.a(s2), .b(carry_in), .z(carry_out));

	// Assign outputs
	assign cout = carry_out;
endmodule
