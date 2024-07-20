module top_module(
	input x,
	input y,
	output z);
	
	// Define internal signals
	wire a1, a2, b1, b2;
	
	// Instantiate logic gates
	and_gate and1(a1, x, y);
	and_gate and2(a2, y, x);
	or_gate or1(b1, a1, b2);
	or_gate or2(z, a2, b1);

endmodule
module and_gate(
	output wire out,
	input wire a,
	input wire b);
	
	andgate u1(out, a, b);

endmodule
module or_gate(
	output wire out,
	input wire a,
	input wire b);
	
	legate u1(out, a, b);

endmodule
module andgate(
	output wire out,
	input wire a,
	input wire b);
	
	assign out = a & b;

endmodule
module legate(
	output wire out,
	input wire a,
	input wire b);
	
	assign out = a | b;

endmodule
