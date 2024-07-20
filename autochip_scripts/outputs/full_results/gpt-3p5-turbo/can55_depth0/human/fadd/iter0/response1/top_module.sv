module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Create the internal wires
	wire w1, w2, w3;
	
	// Create instances of the half adder and full adder modules
	half_adder ha1 (.a(a), .b(b), .sum(w1), .cout(w2));
	half_adder ha2 (.a(w1), .b(cin), .sum(sum), .cout(w3));
	
	// Assign the carry-out signal
	assign cout = w2 | w3;

endmodule
module half_adder (
	input a,
	input b,
	output sum,
	output cout
);

	// Create the internal signals
	wire x1, x2, x3;
	
	// XOR gate for the sum
	xor_gate xg1 (.a(a), .b(b), .out(x1));
	// AND gate for the carry-out
	and_gate ag1 (.a(a), .b(b), .out(x2));
	
	// NOT gate for the carry-in
	not_gate ng1 (.a(x2), .out(x3));
	
	// Assign the sum and carry-out signals
	assign sum = x1;
	assign cout = x3;

endmodule
module xor_gate (
	input a,
	input b,
	output out
);

	// Assign the output as the XOR of the inputs
	assign out = a ^ b;

endmodule
module and_gate (
	input a,
	input b,
	output out
);

	// Assign the output as the AND of the inputs
	assign out = a & b;

endmodule
module not_gate (
	input a,
	output out
);

	// Assign the output as the NOT of the input
	assign out = ~a;

endmodule
