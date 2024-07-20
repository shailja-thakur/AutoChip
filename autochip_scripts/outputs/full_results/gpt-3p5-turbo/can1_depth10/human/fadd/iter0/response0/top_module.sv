module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Define internal wires and signals
	wire w1, w2, w3, w4;
	
	// Instantiate the full adder
	full_adder FA1 (
		.a(a),
		.b(b),
		.cin(cin),
		.sum(sum),
		.cout(w1)
	);
	
	// Instantiate another full adder to handle the carry-out
	full_adder FA2 (
		.a(w1),
		.b(w4),
		.cin(w2),
		.sum(w3),
		.cout(cout)
	);
	
	// Instantiate an AND gate for cin and w4
	and_gate AND1 (
		.a(cin),
		.b(w4),
		.z(w2)
	);
	
	// Instantiate an OR gate for the two carry-out options
	or_gate OR1 (
		.a(w1),
		.b(w3),
		.z(w4)
	);
	
	// Define the full adder module
	module full_adder (
		input a,
		input b,
		input cin,
		output sum,
		output cout
	);
		
		// Define internal wires for the sum calculation
		wire s1, s2, s3;
		
		// Instantiate a XOR gate for a and b
		xor_gate XOR1 (
			.a(a),
			.b(b),
			.z(s1)
		);
		
		// Instantiate a XOR gate for s1 and cin
		xor_gate XOR2 (
			.a(s1),
			.b(cin),
			.z(sum)
		);
		
		// Instantiate an AND gate for a and b
		and_gate AND1 (
			.a(a),
			.b(b),
			.z(s2)
		);
		
		// Instantiate an AND gate for s1 and cin
		and_gate AND2 (
			.a(s1),
			.b(cin),
			.z(s3)
		);
		
		// Instantiate an OR gate for s2 and s3
		or_gate OR1 (
			.a(s2),
			.b(s3),
			.z(cout)
		);
		
	endmodule
module xor_gate (
		input a,
		input b,
		output z
	);
		
		// Define the XOR logic
		assign z = a ^ b;
		
	endmodule
module and_gate (
		input a,
		input b,
		output z
	);
		
		// Define the AND logic
		assign z = a & b;
		
	endmodule
module or_gate (
		input a,
		input b,
		output z
	);
		
		// Define the OR logic
		assign z = a | b;
		
	endmodule
