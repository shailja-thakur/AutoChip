module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    wire [99:0] in_shifted;
    assign in_shifted = {in[98:0], 1'b0}; // Shift in by 1 bit to the right

    // out_both is the bitwise AND of in and in_shifted for bits 0 to 98
    assign out_both = in[98:0] & in_shifted[98:0];

    // out_any is the bitwise OR of in and in_shifted
    assign out_any = in | in_shifted;

    // out_different is the bitwise XOR of in and in_shifted
    assign out_different = in ^ {1'b0, in[99:1]};

endmodule
