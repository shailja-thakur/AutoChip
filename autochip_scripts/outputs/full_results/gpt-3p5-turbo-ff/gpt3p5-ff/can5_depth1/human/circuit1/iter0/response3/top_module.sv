module top_module (
    input a, 
    input b, 
    output q
);
	
	assign q = a & ~b; // bitwise AND of a and negation of b
	
endmodule
