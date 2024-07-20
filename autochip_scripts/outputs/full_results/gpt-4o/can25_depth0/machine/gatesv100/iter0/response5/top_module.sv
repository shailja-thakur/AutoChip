module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:0] out_any,
	output [99:0] out_different
);

    wire [99:0] in_shifted;
    
    assign in_shifted = {in[98:0], 1'b0};  // Right shift 'in' by 1 and fill LSB with 0
    
    assign out_both = in[99:1] & in_shifted[99:1];  // Bit-wise AND for 99-bit wide output
    assign out_any = in | in_shifted;  // Bit-wise OR for 100-bit wide output
    assign out_different[99:1] = in[99:1] ^ in_shifted[99:1];  // Bit-wise XOR for 100-bit wide output
    assign out_different[0] = in[0] ^ in_shifted[99];  // XOR between first bit of 'in' and last bit of 'in_shifted'

endmodule
