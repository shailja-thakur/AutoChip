module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Define internal signals
	wire w1, w2;

	// Assign internal signals based on combinational logic
	assign w1 = ~(a | b);
	assign w2 = ~(c & d);

	// Assign output q based on internal signals
	assign q = w1 & w2;

endmodule
