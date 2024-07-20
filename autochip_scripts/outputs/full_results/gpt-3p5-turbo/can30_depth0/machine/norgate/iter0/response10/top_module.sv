module top_module(
    input a,
    input b,
    output out
);
	
	assign out = ~(a | b); // Logical negation of the logical OR of inputs a and b
	
endmodule
