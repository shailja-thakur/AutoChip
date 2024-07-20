module top_module (
	input a,
	input b,
	input c,
	input d,
	output q
);
	
	// Define internal wire(s)
	wire w1;
	
	// Assign statements
	assign w1 = ~(a & (b | c | d));
	assign q = w1;
	
endmodule
