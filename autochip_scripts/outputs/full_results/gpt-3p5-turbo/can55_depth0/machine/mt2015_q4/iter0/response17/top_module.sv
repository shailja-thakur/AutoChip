module top_module(
	input x,
	input y,
	output z
);
	
	// Gates - Instantiating AND, OR, and NOT gates
	and_gate and1(x, y, a1);
	and_gate and2(y, x, a2);
	or_gate or1(a1, a2, b);
	not_gate not1(b, z);
	
endmodule
module and_gate(
	input a,
	input b,
	output out
);
	and u1(a, b, out);
endmodule
module or_gate(
	input a,
	input b,
	output out
);
	or u1(a, b, out);
endmodule
module not_gate(
	input a,
	output out
);
	not u1(a, out);
endmodule
