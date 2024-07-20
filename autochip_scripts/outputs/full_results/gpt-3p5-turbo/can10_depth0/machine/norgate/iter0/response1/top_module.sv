module top_module(
	input a, 
	input b,
	output out
);
	// Define internal wire
	wire or_out;
	
	// Create OR gate
	or_gate gate1(
		.input_a(a),
		.input_b(b),
		.output(or_out)
	);
	
	// Create inverter
	inverter inv1(
		.input(or_out),
		.output(out)
	);
	
endmodule
module or_gate(
	input input_a,
	input input_b,
	output output
);
	assign output = input_a | input_b;
endmodule
module inverter(
	input input,
	output output
);
	assign output = ~input;
endmodule
