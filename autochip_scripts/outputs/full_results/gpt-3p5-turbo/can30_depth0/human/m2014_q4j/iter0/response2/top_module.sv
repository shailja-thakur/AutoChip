module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

	// Internal signals
	wire [3:0] carry;
	wire [3:0] sum_temp;

	// Full Adder instances
	full_adder fa0(.x(x[0]), .y(y[0]), .cin(1'b0), .sum(sum_temp[0]), .cout(carry[0]));
	full_adder fa1(.x(x[1]), .y(y[1]), .cin(carry[0]), .sum(sum_temp[1]), .cout(carry[1]));
	full_adder fa2(.x(x[2]), .y(y[2]), .cin(carry[1]), .sum(sum_temp[2]), .cout(carry[2]));
	full_adder fa3(.x(x[3]), .y(y[3]), .cin(carry[2]), .sum(sum_temp[3]), .cout(carry[3]));

	// Combinational logic
	assign sum = {carry[3], sum_temp[3:0]};

endmodule
module full_adder (
	input x,
	input y,
	input cin,
	output sum,
	output cout
);
	
	// Internal signals
	wire s;
	wire c1, c2;
	
	// XOR gates
	xor_gate xor1(.a(x), .b(y), .c(s));
	xor_gate xor2(.a(s), .b(cin), .c(sum));
	
	// AND gates
	and_gate and1(.a(x), .b(y), .c(c1));
	and_gate and2(.a(s), .b(cin), .c(c2));
	
	// OR gate
	or_gate or1(.a(c1), .b(c2), .c(cout));
	
endmodule
module xor_gate (
	input a,
	input b,
	output c
);
	assign c = a ^ b;
endmodule
module and_gate (
	input a,
	input b,
	output c
);
	assign c = a & b;
endmodule
module or_gate (
	input a,
	input b,
	output c
);
	assign c = a | b;
endmodule
