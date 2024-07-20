module top_module(
	input x,
	input y,
	output z);

	// Instantiate A and B submodules
	A a1(x, y, a1_out);
	B b1(x, y, b1_out);
	A a2(x, y, a2_out);
	B b2(x, y, b2_out);
	
	// Instantiate gates
	OR gate_or(a1_out, b1_out, or_out);
	AND gate_and(a2_out, b2_out, and_out);
	XOR gate_xor(or_out, and_out, z);

endmodule
module A(
	input x,
	input y,
	output z);
	
	assign z = (x ^ y) & x;

endmodule
module B(
	input x,
	input y,
	output z);

	assign z = #(5) waveform;

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
