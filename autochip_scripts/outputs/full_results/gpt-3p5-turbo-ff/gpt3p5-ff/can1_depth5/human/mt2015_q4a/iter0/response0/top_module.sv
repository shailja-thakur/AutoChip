module top_module(
	input x,
	input y,
	output z);

	// Declare internal wire
	wire w1;

	// xor gate between x and y
	xor_gate XOR1 (.a(x), .b(y), .o(w1));

	// AND gate between w1 and x
	and_gate AND1 (.a(w1), .b(x), .o(z));

endmodule
module xor_gate(
	input a,
	input b,
	output o);
	xor XO1 (.a(a), .b(b), .o(o));
endmodule
module and_gate(
	input a,
	input b,
	output o);
	and AO1 (.a(a), .b(b), .o(o));
endmodule
