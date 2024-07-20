module top_module(
	input x,
	input y,
	output z);

	// Define internal signals
	wire a;
	wire b;
	wire c;

	// Instantiate gates
	and_gate and1(.a(x), .b(y), .z(a));
	and_gate and2(.a(y), .b(x), .z(b));
	and_gate and3(.a(a), .b(b), .z(c));
	
	// Assign z output
	assign z = c;

endmodule
module and_gate(
	input a,
	input b,
	output z
);
	assign z = a & b;
endmodule
