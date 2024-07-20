module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Internal wires
	wire w1, w2, w3;
	
	// XOR gates for sum calculation
	xor_gate u1 (.a(a), .b(b), .z(w1));
	xor_gate u2 (.a(w1), .b(cin), .z(sum));
	
	// AND gates for carry-out calculation
	and_gate u3 (.a(a), .b(b), .z(w2));
	and_gate u4 (.a(w1), .b(cin), .z(w3));
	and_gate u5 (.a(a), .b(cin), .z(w4));
	and_gate u6 (.a(w1), .b(w4), .z(cout));
	
endmodule
