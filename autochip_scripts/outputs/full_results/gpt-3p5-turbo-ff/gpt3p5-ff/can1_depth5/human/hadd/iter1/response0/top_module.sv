module xor_gate (
	input a,
	input b,
	output z
);
	assign z = a ^ b;
endmodule
module and_gate (
	input a,
	input b,
	output z
);
	assign z = a & b;
endmodule
module or_gate (
	input a,
	input b,
	output z
);
	assign z = a | b;
endmodule
module top_module (
	input a,
	input b,
	output sum,
	output cout
);

	// Define signals for the internal wires
	wire G, P;

	// Define internal gates
	xor_gate x1(.a(a), .b(b), .z(sum));
	and_gate a1(.a(a), .b(b), .z(G));
	and_gate a2(.a(a), .b(b), .z(P));
	or_gate o1(.a(G), .b(P), .z(cout));

endmodule
