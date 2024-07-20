module top_module (
	input a, 
	input b, 
	output q
);
	
	assign q = a & b; // Use bitwise AND operator to perform AND operation between a and b
	
endmodule
