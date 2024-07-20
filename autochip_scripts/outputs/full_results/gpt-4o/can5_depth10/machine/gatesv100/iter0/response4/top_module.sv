module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:0] out_any,
	output [99:0] out_different
);

    wire [99:0] shifted_in;
    assign shifted_in = {in[98:0], 1'b0}; // Shift the input signal by one bit

    assign out_both = in[99:1] & shifted_in[98:0]; // 99-bit wide AND operation
    assign out_any = in | shifted_in; // 100-bit wide OR operation

    assign out_different[99] = in[99] ^ shifted_in[99]; // Explicitly define the first bit
    assign out_different[98:0] = in[98:0] ^ {in[97:0], 1'b0}; // 100-bit wide XOR operation with shifted input shifted by one bit

endmodule
