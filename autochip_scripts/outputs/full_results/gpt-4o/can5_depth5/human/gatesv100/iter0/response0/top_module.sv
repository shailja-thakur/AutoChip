module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

    // Compute out_both
    assign out_both = in[99:1] & in[98:0];
    
    // Compute out_any
    assign out_any = in[99:1] | in[98:0];
    
    // Compute out_different
    assign out_different = in ^ {in[0], in[99:1]};

endmodule
