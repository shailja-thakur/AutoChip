module top_module(
	input a, 
	input b,
	output out
);

// Declare internal wire for XOR operation
wire xor_result;

// XOR operation
assign xor_result = a ^ b;

// Negation and output assignment
assign out = ~xor_result;

endmodule
