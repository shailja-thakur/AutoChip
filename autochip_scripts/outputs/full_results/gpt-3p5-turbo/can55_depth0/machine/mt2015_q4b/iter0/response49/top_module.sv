module top_module(
	input x,
	input y,
	output z);
	
	// Declare internal wires
	wire xor_output;
	
	// XOR gate instantiation
	xor_gate xor_inst(.x(x), .y(y), .z(xor_output));
	
	// NOT gate instantiation
	not_gate not_inst(.a(xor_output), .z(z));
	
endmodule
module xor_gate(
	input x,
	input y,
	output z);
	
	assign z = x ^ y;
	
endmodule
module not_gate(
	input a,
	output z);
	
	assign z = ~a;
	
endmodule
