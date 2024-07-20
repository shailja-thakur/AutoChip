module top_module (
	input a, 
	input b, 
	output q
);
	
	assign q = (a & ~b) | (~a & b);
	
endmodule
