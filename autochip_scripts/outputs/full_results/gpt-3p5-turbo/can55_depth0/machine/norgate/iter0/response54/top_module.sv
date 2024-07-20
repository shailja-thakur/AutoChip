module top_module(
	input a, 
	input b,
	output out
);

	// OR gate
	wire or_out;
	or_gate or1(a,b,or_out);
	
	// Inverter
	inverter inv1(or_out, out);
	
endmodule
module or_gate(
	input a,
	input b,
	output out
);
	
	assign out = a | b;
	
endmodule
module inverter(
	input inp,
	output out
);
	
	assign out = ~inp;
	
endmodule
