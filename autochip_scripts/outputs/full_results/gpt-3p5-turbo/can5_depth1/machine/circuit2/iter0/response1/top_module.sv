module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

// XOR operation
wire xor1 = a ^ b;
wire xor2 = c ^ d;

// NOT operation
assign q = ~ (xor1 ^ xor2);

endmodule
