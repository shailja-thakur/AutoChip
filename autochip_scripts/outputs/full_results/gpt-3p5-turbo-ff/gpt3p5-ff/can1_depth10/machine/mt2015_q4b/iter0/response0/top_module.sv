module top_module(
	input x,
	input y,
	output z);
	
	// Function: xor function
	// Description: Implements the xor gate logic
	// Inputs: a, b
	// Outputs: res
	// res = a xor b
	function xor_function;
		input a, b;
		output res;
		assign res = a ^ b;
	endfunction
	
	// Function: negation function
	// Description: Implements negation logic
	// Inputs: a
	// Outputs: res
	// res = not a
	function negation_function;
		input a;
		output res;
		assign res = ~a;
	endfunction
	
	// Internal wires
	wire xor_result;
	wire negation_result;
	
	// Instantiate xor_function
	xor_function xor_gate(x, y, xor_result);
	
	// Instantiate negation_function
	negation_function negation_gate(xor_result, negation_result);
	
	// Assign output
	assign z = negation_result;
	
endmodule
