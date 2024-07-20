module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    // Shifted version of input signal (one bit to the left)
    wire [99:0] in_shifted;
    assign in_shifted = {in[98:0], 1'b0}; // Shift left and pad the rightmost bit with 0

    // out_both: Bit-wise AND result (99-bit wide)
    assign out_both = in[98:0] & in_shifted[98:0];

    // out_any: Bit-wise OR result (100-bit wide)
    assign out_any = in | in_shifted;

    // out_different: Bit-wise XOR result (100-bit wide)
    assign out_different = in ^ in_shifted;

endmodule
