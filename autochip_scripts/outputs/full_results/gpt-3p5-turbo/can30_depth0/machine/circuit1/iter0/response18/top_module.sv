module top_module (
	input a, 
	input b, 
	output q
);
    assign q = a & b; // Performs the logical AND operation between inputs a and b, and assigns the result to output q
endmodule
