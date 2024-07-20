module top_module(
	input x,
	input y,
	output z);

	// Declaration of internal signals
	wire a, b;

	// Instantiation of gates
	and_gate and_gate1 (.a = x, .b = y, .z = a);
	and_gate and_gate2 (.a = y, .b = x, .z = b);
	or_gate or_gate1 (.a = a, .b = b, .z = z);
	
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
