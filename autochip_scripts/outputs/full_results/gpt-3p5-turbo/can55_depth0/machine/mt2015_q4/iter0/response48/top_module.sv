module top_module(
	input x,
	input y,
	output z);
	
	// Define internal signals and wires
	wire a1, a2, b1, b2, c1, c2;
	
	// Instantiate logic gates
	and_gate and1(a1, x, y);
	and_gate and2(a2, x, y);
	or_gate or1(b1, a1, b2);
	or_gate or2(b2, a2, a1);
	and_gate and3(c1, b1, b2);
	
	// Assign the output
	assign z = c1;
	
endmodule
module and_gate(
	input a,
	input b,
	output c);
	
	assign c = a & b;
	
endmodule
module or_gate(
	input a,
	input b,
	output c);
	
	assign c = a | b;
	
endmodule
