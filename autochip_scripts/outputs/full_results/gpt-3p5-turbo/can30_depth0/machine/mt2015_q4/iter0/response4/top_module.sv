module top_module(
	input x,
	input y,
	output z);

	// Gates
	wire a;
	wire b;

	// Gate 1
	and_gate and1(.a=x, .b=y, .z=a);

	// Gate 2
	and_gate and2(.a=y, .b=x, .z=b);

	// Gate 3
	or_gate or1(.a=a, .b=b, .z=z);

endmodule
module and_gate(
	input a,
	input b,
	output z);

	assign z = a & b;

endmodule
module or_gate(
	input a,
	input b,
	output z);

	assign z = a | b;

endmodule
