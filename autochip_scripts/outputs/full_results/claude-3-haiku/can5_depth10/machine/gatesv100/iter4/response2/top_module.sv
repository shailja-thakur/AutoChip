module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    // Shift in by 1 bit
    wire [99:0] in_shifted;
    assign in_shifted = {in[98:0], 1'b0};

    // Bit-wise operations
    assign out_both = in & in_shifted;
    assign out_any = in | in_shifted;
    assign out_different = {in[99] ^ in_shifted[99], in[98:0] ^ in_shifted[98:0]};

endmodule
