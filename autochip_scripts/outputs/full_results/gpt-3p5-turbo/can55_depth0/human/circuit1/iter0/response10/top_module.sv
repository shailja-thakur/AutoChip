module top_module (
	input a, 
	input b, 
	output q
);

	// combinational logic
	assign q = (a & b);

endmodule
