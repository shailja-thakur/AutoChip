module top_module(
	input x,
	input y,
	output z);

	// internal wires
	wire xor_result, or_result;
	
	// instantiating xor gate
	xor_gate xor_inst (.x(x), .y(y), .z(xor_result));
	
	// instantiating or gate
	or_gate or_inst (.x(x), .y(y), .z(or_result));
	
	// instantiating not gate
	not_gate not_inst (.x(xor_result), .z(z));
	
endmodule
