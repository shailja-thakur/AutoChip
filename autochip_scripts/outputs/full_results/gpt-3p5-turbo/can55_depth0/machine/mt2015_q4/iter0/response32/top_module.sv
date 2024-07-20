module top_module(
	input x,
	input y,
	output z);

	// Define internal signals for intermediate outputs
	wire a1, b1, a2, b2;

	// Instantiate the gates
	and_gate and1(.a=x, .b=y, .z=a1);
	and_gate and2(.a=y, .b=x, .z=b1);
	and_gate and3(.a=a1, .b=b1, .z=z);

endmodule
module and_gate(
	input a,
	input b,
	output z);

	assign z = a & b;

endmodule
