module top_module (
	input a, 
	input b, 
	output q
);
	assign q = a & (~b); // Perform the AND operation between input a and the negation of input b
endmodule
