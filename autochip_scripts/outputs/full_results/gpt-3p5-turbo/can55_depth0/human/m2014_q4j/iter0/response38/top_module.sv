module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);
	// Instantiate four full adders
	full_adder adder0(.a(x[0]), .b(y[0]), .cin(1'b0), .sum(sum[0]), .cout(carry[0]));
	full_adder adder1(.a(x[1]), .b(y[1]), .cin(carry[0]), .sum(sum[1]), .cout(carry[1]));
	full_adder adder2(.a(x[2]), .b(y[2]), .cin(carry[1]), .sum(sum[2]), .cout(carry[2]));
	full_adder adder3(.a(x[3]), .b(y[3]), .cin(carry[2]), .sum(sum[3]), .cout(overflow));
	
	// Assign overflow bit to the 5th bit of the sum
	assign sum[4] = overflow;
endmodule
module full_adder (
	input a,
	input b,
	input cin,
	output sum,
	output cout
);
	// Create intermediate signals for sum and carry
	wire s;
	wire c1;
	wire c2;
	
	// Implement XOR and AND gates for the full adder logic
	xor_gate xor1(.a(a), .b(b), .out(s));
	and_gate and1(.a(a), .b(b), .out(c1));
	and_gate and2(.a(s), .b(cin), .out(c2));
	
	// Implement sum and carry output
	assign sum = s ^ cin;
	assign cout = c1 | c2;
endmodule
module xor_gate(
	input a,
	input b,
	output out
);
	assign out = a ^ b;
endmodule
module and_gate(
	input a,
	input b,
	output out
);
	assign out = a & b;
endmodule
