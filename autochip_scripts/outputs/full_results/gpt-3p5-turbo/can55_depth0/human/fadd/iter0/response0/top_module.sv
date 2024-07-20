module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

// Correct module declaration, no changes needed

// Declare internal wire for sum bit
wire sum_wire;

// Declare internal wire for carry bit
wire carry_wire;

// Instantiate full adder module
full_adder adder_inst (
	.a(a),
	.b(b),
	.cin(cin),
	.cout(carry_wire),
	.sum(sum_wire)
);

// Assign internal wire values to module outputs
assign cout = carry_wire;
assign sum = sum_wire;

endmodule
module full_adder (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

// Declare internal wires for carry, sum, and intermediate carry
wire carry_1;
wire sum_1;
wire carry_2;

// First stage: half adder to calculate sum and intermediate carry
half_adder ha1 (
	.a(a),
	.b(b),
	.sum(sum_1),
	.carry(carry_1)
);

// Second stage: half adder to calculate final sum and carry out
half_adder ha2 (
	.a(sum_1),
	.b(cin),
	.sum(sum),
	.carry(carry_2)
);

// OR gate to calculate final carry out
or_gate or(
	.input1(carry_1),
	.input2(carry_2),
	.output(cout)
);

endmodule
module half_adder (
	input a,
	input b,
	output sum,
	output carry
);

// XOR gate to calculate sum
xor_gate xor(
	.input1(a),
	.input2(b),
	.output(sum)
);

// AND gate to calculate carry
and_gate and(
	.input1(a),
	.input2(b),
	.output(carry)
);

endmodule
module xor_gate (
	input input1,
	input input2,
	output output
);
	
// XOR gate implementation
	assign output = input1 ^ input2;

endmodule
module and_gate (
	input input1,
	input input2,
	output output
);

// AND gate implementation
	assign output = input1 & input2;

endmodule
module or_gate (
	input input1,
	input input2,
	output output
);

// OR gate implementation
	assign output = input1 | input2;

endmodule
