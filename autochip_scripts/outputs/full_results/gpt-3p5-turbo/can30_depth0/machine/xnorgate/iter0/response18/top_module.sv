module top_module(
	input a, 
	input b,
	output out
);
    // Implementation
    assign out = ~(a ^ b);
endmodule
