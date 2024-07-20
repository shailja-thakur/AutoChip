module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:0] out_any,
	output [99:0] out_different
);

    wire [99:0] in_shifted;
    
    // Shift the input signal to the left by 1 bit
    assign in_shifted = {in[98:0], 1'b0};

    // Generate out_both
    assign out_both = in[98:0] & in_shifted[98:0];

    // Generate out_any
    assign out_any = in | in_shifted;

    // Generate out_different
    assign out_different[0] = in[0] ^ in[99];
    assign out_different[99:1] = in[99:1] ^ in_shifted[99:1];

endmodule
