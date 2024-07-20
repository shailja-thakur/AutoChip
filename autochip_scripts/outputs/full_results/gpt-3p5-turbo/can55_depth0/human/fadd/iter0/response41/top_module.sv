module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Declare internal wires
	wire w1, w2, w3;

	// Instantiate the full adder module
	full_adder FA1 (.a(a), .b(b), .cin(cin), .sum(w1), .cout(w2));
	full_adder FA2 (.a(w1), .b(w2), .cin(w3), .sum(sum), .cout(cout));

	// Define the full adder module
	module full_adder (
		input a,
		input b,
		input cin,
		output sum,
		output cout
	);
		wire w4, w5, w6;
		xor_gate XOR1 (.a(a), .b(b), .out(w4));
		xor_gate XOR2 (.a(w4), .b(cin), .out(sum));
		and_gate AND1 (.a(a), .b(b), .out(w5));
		and_gate AND2 (.a(a), .b(cin), .out(w6));
		and_gate AND3 (.a(b), .b(cin), .out(cout));
		or_gate OR1 (.a(w5), .b(w6), .out(w3));
		or_gate OR2 (.a(w3), .b(w7), .out(cout));
	endmodule
module xor_gate (
		input a,
		input b,
		output out
	);
		assign out = a ^ b;
	endmodule
module and_gate (
		input a,
		input b,
		output out
	);
		assign out = a & b;
	endmodule
module or_gate (
		input a,
		input b,
		output out
	);
		assign out = a | b;
	endmodule
