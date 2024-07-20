module top_module(
	input x,
	input y,
	output z);
	
	// Declare internal wires
	wire a_in_first_gate, b_in_first_gate, a_in_second_gate, b_in_second_gate, a_in_third_gate;
	
	// Instantiate logic gates
	and_gate and1 (.a(x), .b(y), .z(a_in_first_gate));        // First AND gate with inputs x and y, and output a_in_first_gate
	and_gate and2 (.a(y), .b(x), .z(b_in_first_gate));        // Second AND gate with inputs y and x, and output b_in_first_gate
	and_gate and3 (.a(a_in_first_gate), .b(b_in_first_gate), .z(a_in_third_gate));        // Third AND gate with inputs a_in_first_gate and b_in_first_gate, and output a_in_third_gate
	
	// Instantiate output buffer
	buffer buffer1 (.a(a_in_third_gate), .z(z));        // Buffer with input a_in_third_gate and output z
	
endmodule
module and_gate(
	input a,
	input b,
	output z);
	
	// Logic to perform AND operation
	assign z = a & b;
	
endmodule
module buffer(
	input a,
	output z);
	
	// Assign input to output
	assign z = a;
	
endmodule
