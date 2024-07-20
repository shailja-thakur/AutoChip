module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

// Wire to store the XOR result
wire xor_result;

// XOR gate for a,b,c,d
assign xor_result = a ^ b ^ c ^ d;

// Inverter to invert the result
assign q = ~xor_result;

endmodule
