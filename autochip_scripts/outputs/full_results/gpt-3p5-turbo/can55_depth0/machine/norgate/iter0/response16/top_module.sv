module top_module(
	input a, 
	input b,
	output out
);
	// OR gate
	wire or_gate_output;
	or_gate or1(a, b, or_gate_output);
	
	// Inverter
	wire inv_output;
	inverter inv1(or_gate_output, inv_output);
	
	assign out = inv_output;
endmodule
module or_gate(
	input a,
	input b,
	output out
);
	assign out = a | b;
endmodule
module inverter(
	input in,
	output out
);
	assign out = ~in;
endmodule
