module top_module(
	input x,
	input y,
	output z
);  
	// assign z = NOT(x XOR y)
	assign z = ~(x ^ y);
endmodule
