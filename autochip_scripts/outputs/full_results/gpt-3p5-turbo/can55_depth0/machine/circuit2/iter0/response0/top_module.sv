module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

// Intermediate signal for XOR operation
wire xor_out;

// XOR gate for a and b inputs
assign xor_out = a ^ b;

// XOR gate for c and d inputs
assign xor_out = xor_out ^ (c ^ d);

// Inverter for the output
assign q = ~xor_out;

endmodule
