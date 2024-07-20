module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
	
	// Internal wire for intermediate calculations
	wire q_temp;
	
	// Logic to perform XOR operation on inputs a, b, c, and d
	// Assign the result to q_temp
	assign q_temp = a ^ b ^ c ^ d;
	
	// Logic to invert the result and assign it to output q
	assign q = ~q_temp;
	
endmodule
