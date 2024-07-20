module top_module(
	input a, 
	input b,
	output out
);
	// Declare the internal wire
	wire internal_wire;
	
	// Instantiate the AND gate
	and gate1(
		.a(a),
		.b(b),
		.out(internal_wire)
	);
	
	// Assign the output
	assign out = internal_wire;
endmodule
