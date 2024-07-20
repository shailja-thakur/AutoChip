module top_module(
	input x,
	input y,
	output z);
	
	// Define signals
	wire a, b;
	
	// Instantiate gates
	and_gate and1(x, y, a);
	and_gate and2(y, x, b);
	and_gate and3(a, b, z);
	
endmodule
module and_gate(
	input a,
	input b,
	output c);
	
	assign c = a & b;
	
endmodule
