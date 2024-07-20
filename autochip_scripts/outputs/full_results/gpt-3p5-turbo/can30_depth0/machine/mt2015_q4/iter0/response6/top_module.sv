module top_module(
	input wire x,
	input wire y,
	output wire z);

	// Define inputs for the gates
	wire a, b;

	// Instantiate gates
	and_gate and1(a, x, y);
	and_gate and2(b, y, x);
	and_gate and3(z, a, b);
	
endmodule
module and_gate(
	output wire out,
	input wire in1,
	input wire in2);
	
	assign out = in1 & in2;
	
endmodule
