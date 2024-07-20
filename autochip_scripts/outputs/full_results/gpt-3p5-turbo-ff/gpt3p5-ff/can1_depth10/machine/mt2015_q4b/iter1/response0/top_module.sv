module xor_gate(
	input a,
	input b,
	output res
);
	assign res = a ^ b;
endmodule
module negation_gate(
	input a,
	output res
);
	assign res = ~a;
endmodule
module top_module(
	input x,
	input y,
	output z
);
	
	// Internal wires
	wire xor_result;
	wire negation_result;
	
	// Instantiate xor_gate
	xor_gate xor_inst (.a(x), .b(y), .res(xor_result));
	
	// Instantiate negation_gate
	negation_gate negation_inst (.a(xor_result), .res(negation_result));
	
	// Assign output
	assign z = negation_result;
	
endmodule
