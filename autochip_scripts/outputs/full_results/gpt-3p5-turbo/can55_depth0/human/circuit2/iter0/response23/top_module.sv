module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	/* declare internal wires */
	wire a_and_b;
	wire c_or_d;
	
	/* assign internal wire values */
	assign a_and_b = a & b;
	assign c_or_d = c | d;
	
	/* assign output */
	assign q = ~ (a_and_b & c_or_d);

endmodule
