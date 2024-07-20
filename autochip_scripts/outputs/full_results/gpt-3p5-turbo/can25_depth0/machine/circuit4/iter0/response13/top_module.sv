module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

// logic gate to OR inputs b and c
assign q = b || c;

endmodule
