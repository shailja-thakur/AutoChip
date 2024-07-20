module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    // Shift the input vector by one bit
    wire [99:0] shifted = {in[98:0], in[99]};

    // Perform the required bitwise operations
    assign out_both = in & shifted;
    assign out_any = in | shifted;
    assign out_different = in ^ shifted;

endmodule
