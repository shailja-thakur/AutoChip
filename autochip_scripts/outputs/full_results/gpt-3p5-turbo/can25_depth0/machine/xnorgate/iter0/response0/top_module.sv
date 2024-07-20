module top_module(
    input a,
    input b,
    output out
);
	
	// xor gates
	assign out = ~(a ^ b);
	
endmodule
