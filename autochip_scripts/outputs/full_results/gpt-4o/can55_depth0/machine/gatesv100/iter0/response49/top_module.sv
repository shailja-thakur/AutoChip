module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:0] out_any,
	output [99:0] out_different
);

    wire [99:0] shifted_in;

    assign shifted_in = {in[98:0], 1'b0};                           // Shift in vector by one bit.
    assign out_both = in[99:1] & in[98:0];                          // Bit-wise AND operation for 99-bit out_both.
    assign out_any = in | shifted_in;                               // Bit-wise OR operation for 100-bit out_any.
    assign out_different[0] = in[0] ^ in[99];                       // Bit-wise XOR operation for first bit of out_different.
    assign out_different[99:1] = in[99:1] ^ in[98:0];               // Bit-wise XOR operation for remaining bits of out_different.

endmodule
