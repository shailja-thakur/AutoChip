module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	// Declare intermediate wires
	wire intermediate1;
	wire intermediate2;

	// Define the circuit
	and gate1 (intermediate1, a, b);
	and gate2 (intermediate2, c, d);
	or gate3 (out, intermediate1, intermediate2);
	not gate4 (out_n, out);

endmodule
module and (
	output reg out,
	input a,
	input b );

	always @(a, b)
		out = a & b;

endmodule
module or (
	output reg out,
	input a,
	input b );

	always @(a, b)
		out = a | b;

endmodule
module not (
	output reg out,
	input a );

	always @(a)
		out = ~a;

endmodule
