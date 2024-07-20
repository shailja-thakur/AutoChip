module top_module(
	input x,
	input y,
	output z);
	
	// Define internal signals
	wire a1, a2, b1, b2;
	
	// Instantiate logic gates
	and_gate and1(a1, x, y);
	and_gate and2(a2, y, x);
	or_gate or1(tmp, a1, b1);
	or_gate or2(tmp, a2, b2);
	not_gate not1(tmp, z);
	
endmodule
module and_gate(
	output wire out,
	input wire a,
	input wire b);
	
	assign out = a & b;

endmodule
module or_gate(
	output wire out,
	input wire a,
	input wire b);
	
	assign out = a | b;

endmodule
module not_gate(
	output wire out,
	input wire in);
	
	assign out = ~in;

endmodule
