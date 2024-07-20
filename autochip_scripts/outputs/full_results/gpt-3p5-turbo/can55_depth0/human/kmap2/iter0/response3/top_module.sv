module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);
	
	// Declare internal signals
	wire w1, w2, w3, w4;
	
	// Implement logic for internal signals
	assign w1 = ~(a & b);
	assign w2 = ~(c & d);
	assign w3 = a & b & c;
	assign w4 = ~(a & ~b & ~d);
	
	// Implement logic for output
	assign out = w1 | w2 | w3 | w4;
	
endmodule
