module top_module(
	input a, 
	input b,
	output out
);
    
    assign out = ~(a ^ b); // XNOR Gate

endmodule
