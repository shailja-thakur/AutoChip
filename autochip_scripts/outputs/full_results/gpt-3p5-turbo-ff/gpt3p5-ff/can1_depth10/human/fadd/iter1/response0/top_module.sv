module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

wire sum1;
wire and1_out;
wire and2_out;
wire and3_out;

// Main full adder module
module full_adder (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);
	// Logic to calculate the sum
	xor_gate xor1 (.a(a), .b(b), .out(sum1));
	xor_gate xor2 (.a(sum1), .b(cin), .out(sum));

	// Logic to calculate the carry
	and_gate and1 (.a(a), .b(b), .out(and1_out));
	and_gate and2 (.a(a), .b(cin), .out(and2_out));
	and_gate and3 (.a(b), .b(cin), .out(and3_out));
	or_gate or1 (.a(and1_out), .b(and2_out), .c(and3_out), .out(cout));
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
	input c,
	output out
);
	assign out = a | b | c;
endmodule
