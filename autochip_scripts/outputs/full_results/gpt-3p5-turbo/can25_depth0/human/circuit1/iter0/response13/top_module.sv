module top_module (
	input a, 
	input b, 
	output q
);
	// Implementing combinational logic
	assign q = ~(a & b);
endmodule
