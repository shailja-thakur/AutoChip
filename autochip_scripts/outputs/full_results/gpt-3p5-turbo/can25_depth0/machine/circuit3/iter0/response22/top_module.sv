module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
	
	// OR logic gates for inputs a and b
	wire a_or_b;
	assign a_or_b = a | b;
	
	// OR logic gates for inputs c and d
	wire c_or_d;
	assign c_or_d = c | d;
	
	// AND logic gate for a_or_b and c_or_d
	assign q = a_or_b & c_or_d;
	
endmodule
