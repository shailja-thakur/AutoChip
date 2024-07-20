module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

// Internal wires
wire w1, w2, w3;

// XOR gates for inputs
xor_gate xor1 (.a(a), .b(b), .o(w1));
xor_gate xor2 (.a(w1), .b(cin), .o(sum));

// AND gates for inputs
and_gate and1 (.a(a), .b(b), .o(w2));
and_gate and2 (.a(w1), .b(cin), .o(w3));

// OR gate for carry-out
or_gate or1 (.a(w2), .b(w3), .o(cout));

endmodule
