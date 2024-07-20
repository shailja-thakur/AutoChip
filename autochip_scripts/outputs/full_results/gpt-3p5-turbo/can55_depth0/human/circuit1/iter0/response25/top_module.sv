module top_module (
	input a, 
	input b, 
	output q
);
	
	// Declare intermediate signals
	wire and_output, or_output;
	
	// Implement the circuit logic
	and gate1(.a(a), .b(b), .z(and_output));
	or gate2(.a(a), .b(b), .z(or_output));
	
	// Assign the output signal
	assign q = and_output | or_output;
	
endmodule
module and (
	input a, 
	input b, 
	output z
);
	assign z = a & b;
endmodule
module or (
	input a, 
	input b, 
	output z
);
	assign z = a | b;
endmodule
