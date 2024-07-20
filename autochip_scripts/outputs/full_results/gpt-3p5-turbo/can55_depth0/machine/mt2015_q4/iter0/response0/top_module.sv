module top_module(
	input x,
	input y,
	output z);

	// Define internal signals
	wire a, b;

	// Instantiate logic gates
	and_gate and1(x, y, a);
	and_gate and2(y, x, b);
	and_gate and3(a, b, z);

endmodule
module and_gate(
	input a,
	input b,
	output c);

	// Define internal signal
	wire out;

	// Implement AND gate
	assign out = a & b;

	// Output the result
	assign c = out;

endmodule
