module top_module(
	input x,
	input y,
	output z);

	// Instantiate A submodules
	A a1(.x(x), .y(y), .z(a1_z));
	A a2(.x(x), .y(y), .z(a2_z));

	// Instantiate B submodules
	B b1(.x(x), .y(y), .z(b1_z));
	B b2(.x(x), .y(y), .z(b2_z));

	// Instantiate gates
	OR or_gate(.a(a1_z), .b(b1_z), .z(or_z));
	AND and_gate(.a(a2_z), .b(b2_z), .z(and_z));
	XOR xor_gate(.a(or_z), .b(and_z), .z(z));

endmodule
module A(
	input x,
	input y,
	output z);

	assign z = (x^y) & x;

endmodule
module B(
	input x,
	input y,
	output z);

	initial
		begin
			#0 z = 0;
			#25 z = 1;
			#30 z = 0;
			#5 z = 1;
		end

endmodule
module OR(
	input a,
	input b,
	output z);

	assign z = a | b;

endmodule
module AND(
	input a,
	input b,
	output z);

	assign z = a & b;

endmodule
module XOR(
	input a,
	input b,
	output z);

	assign z = a ^ b;

endmodule
