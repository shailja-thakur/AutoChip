module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);
	// Declare internal wires for the full adder
	wire w1, w2, w3;
	
	// Instantiate the full adder module
	full_adder FA(
		.a(a),
		.b(b),
		.cin(cin),
		.cout(w3),
		.sum(w2)
	);
	
	// Connect the output wires from the full adder module to the top module's outputs
	assign cout = w3;
	assign sum = w2;
	
endmodule
module full_adder (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);
	// Declare internal wires for the full adder
	wire w1, w2, w3, w4;
	
	// Instantiate the XOR and half adder modules
	xor_gate XOR1(
		.a(a),
		.b(b),
		.z(w1)
	);
	
	xor_gate XOR2(
		.a(cin),
		.b(w1),
		.z(sum)
	);
	
	half_adder HA(
		.a(w1),
		.b(cin),
		.cout(w3),
		.sum(w2)
	);
	
	// Connect the carry-out of the half adder to the carry-out of the full adder
	assign cout = w3;
	
endmodule
module xor_gate (
	input a,
	input b,
	output z
);
	assign z = a ^ b;
endmodule
module half_adder (
	input a,
	input b,
	output cout,
	output sum
);
	// Declare internal wires for the half adder
	wire w1, w2;
	
	// Instantiate the XOR and AND gates
	xor_gate XOR(
		.a(a),
		.b(b),
		.z(sum)
	);
	
	and_gate AND(
		.a(a),
		.b(b),
		.z(w1)
	);
	
	// Connect the output wires from the AND gate to the internal wires
	assign cout = w1;
	
endmodule
module and_gate (
	input a,
	input b,
	output z
);
	assign z = a & b;
endmodule
