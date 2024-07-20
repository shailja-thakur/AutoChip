module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

	// Declarative region
	wire and_result;
	wire or_result;
	wire xor_result;
	
	// Logic gate instances
	and_gate and_inst (.in(in), .out(and_result));
	or_gate or_inst (.in(in), .out(or_result));
	xor_gate xor_inst (.in(in), .out(xor_result));
	
	// Assignments
	assign out_and = and_result;
	assign out_or = or_result;
	assign out_xor = xor_result;

endmodule
module and_gate (
	input [99:0] in,
	output out
);
	
	// Intermediate wire
	wire [99:0] and_intermediate;
	
	// AND gate
	assign and_intermediate = &in;
	
	// Output assignment
	assign out = and_intermediate;
	
endmodule
module or_gate (
	input [99:0] in,
	output out
);
	
	// Intermediate wire
	wire [99:0] or_intermediate;
	
	// OR gate
	assign or_intermediate = |in;
	
	// Output assignment
	assign out = or_intermediate;
	
endmodule
module xor_gate (
	input [99:0] in,
	output out
);
	
	// Intermediate wire
	wire [99:0] xor_intermediate;
	
	// XOR gate
	assign xor_intermediate = ^in;
	
	// Output assignment
	assign out = xor_intermediate;
	
endmodule
