module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);
	
	// Internal wires
	wire w1, w2, w3;
	
	// Gate-level implementation of full adder
	// XOR gates
	xor_gate xor1(.a(a), .b(b), .o(w1));
	xor_gate xor2(.a(w1), .b(cin), .o(sum));
	
	// AND gates
	and_gate and1(.a(a), .b(b), .o(w2));
	and_gate and2(.a(b), .b(cin), .o(w3));
	and_gate and3(.a(a), .b(cin), .o(w3));
	
	// OR gate
	or_gate or1(.a(w2), .b(w3), .o(cout));

endmodule
module xor_gate (
    input a,
    input b,
    output o
);
    assign o = a ^ b;
endmodule
module and_gate (
    input a,
    input b,
    output o
);
    assign o = a & b;
endmodule
module or_gate (
    input a,
    input b,
    output o
);
    assign o = a | b;
endmodule
