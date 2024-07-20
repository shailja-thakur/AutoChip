module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

	// Instantiate four full adders
	full_adder fa0(.a(x[0]), .b(y[0]), .cin(1'b0), .sum(sum[0]), .cout(carry[0]));
	full_adder fa1(.a(x[1]), .b(y[1]), .cin(carry[0]), .sum(sum[1]), .cout(carry[1]));
	full_adder fa2(.a(x[2]), .b(y[2]), .cin(carry[1]), .sum(sum[2]), .cout(carry[2]));
	full_adder fa3(.a(x[3]), .b(y[3]), .cin(carry[2]), .sum(sum[3]), .cout(carry[3]));
	
	// Connect the overflow bit
	assign sum[4] = carry[3];
	
endmodule
module full_adder (
	input a,
	input b,
	input cin,
	output sum,
	output cout
);

	// Implement the full adder using two half adders and an OR gate
	wire s1, c1, c2;
	
	xor_xor_half_adder xor_adder1(.a(a), .b(b), .sum(s1), .carry(c1));
	xor_xor_half_adder xor_adder2(.a(s1), .b(cin), .sum(sum), .carry(c2));
	or_gate or1(.a(c1), .b(c2), .out(cout));
	
endmodule
module xor_xor_half_adder (
	input a,
	input b,
	output sum,
	output carry
);

	// Implement the half adder using two XOR gates
	xor_gate xor1(.a(a), .b(b), .out(sum));
	xor_gate xor2(.a(a), .b(b), .out(carry));

endmodule
module xor_gate (
	input a,
	input b,
	output out
);

	// Implement the XOR gate
	assign out = a ^ b;

endmodule
module or_gate (
	input a,
	input b,
	output out
);

	// Implement the OR gate
	assign out = a | b;

endmodule
