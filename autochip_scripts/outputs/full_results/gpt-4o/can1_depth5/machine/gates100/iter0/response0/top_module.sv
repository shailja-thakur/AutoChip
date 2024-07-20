module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

    // Generate the AND result
    assign out_and = &in;
    
    // Generate the OR result
    assign out_or = |in;
    
    // Generate the XOR result
    assign out_xor = ^in;
    
endmodule
