module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:0] out_any,
	output [99:0] out_different
);

    // Shift the input vector by 1 bit to the left
    wire [99:0] shifted_in;
    assign shifted_in = in << 1;

    // Generate out_both: bit-wise AND between in and shifted_in (only 99 bits)
    assign out_both = in[99:1] & in[98:0];

    // Generate out_any: bit-wise OR between in and shifted_in
    assign out_any = in | shifted_in;

    // Generate out_different: bit-wise XOR between in and shifted_in
    assign out_different[99:1] = in[99:1] ^ in[98:0];
    assign out_different[0] = in[0] ^ in[99];

endmodule
