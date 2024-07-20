module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);
	// Internal signal declarations
	wire [3:0] carry;
	wire [3:0] sum_3_0;
	wire overflow;
	
	// Instance full adders
	full_adder fa0 (.a(x[0]), .b(y[0]), .cin(1'b0), .sum(sum_3_0[0]), .cout(carry[0]));
	full_adder fa1 (.a(x[1]), .b(y[1]), .cin(carry[0]), .sum(sum_3_0[1]), .cout(carry[1]));
	full_adder fa2 (.a(x[2]), .b(y[2]), .cin(carry[1]), .sum(sum_3_0[2]), .cout(carry[2]));
	full_adder fa3 (.a(x[3]), .b(y[3]), .cin(carry[2]), .sum(sum_3_0[3]), .cout(carry[3]));
	
	// Assign sum and overflow output
	assign sum = {overflow, sum_3_0};
	assign overflow = carry[3];
endmodule
module full_adder (
	input a,
	input b,
	input cin,
	output sum,
	output cout
);
	// Instantiate XOR and AND gates
	xor_gate x1 (.a(a), .b(b), .out(sum_with_cin));
	xor_gate x2 (.a(sum_with_cin), .b(cin), .out(sum));
	and_gate a1 (.a(a), .b(b), .out(a_and_b));
	and_gate a2 (.a(sum_with_cin), .b(cin), .out(cin_and_sum_with_cin));
	or_gate o1 (.a(a_and_b), .b(cin_and_sum_with_cin), .out(cout));
	
	// Internal signal
	wire sum_with_cin;
	wire a_and_b;
	wire cin_and_sum_with_cin;
	
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
