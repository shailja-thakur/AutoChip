module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:0] out_any,
	output [99:0] out_different
);
    // Shift the input by one bit to the right
    wire [99:0] shifted_in = {1'b0, in[99:1]};
   
    // Generate the out_both signal (99-bit result of bit-wise AND operation)
    assign out_both = in[99:1] & shifted_in[98:0];

    // Generate the out_any signal (100-bit result of bit-wise OR operation)
    assign out_any = in | shifted_in;

    // Generate the out_different signal (100-bit result of bit-wise XOR operation)
    assign out_different[99:1] = in[99:1] ^ shifted_in[99:1];
    assign out_different[0] = in[0] ^ shifted_in[99];

endmodule
