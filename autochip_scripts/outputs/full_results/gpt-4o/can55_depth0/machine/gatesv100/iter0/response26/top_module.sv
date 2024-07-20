module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);
    wire [99:0] in_shifted;

    // Shift "in" by 1 bit to the right
    assign in_shifted = {1'b0, in[99:1]};

    // Generate out_both
    assign out_both = in[99:1] & in_shifted[98:0];

    // Generate out_any
    assign out_any = in | in_shifted;

    // Generate out_different
    assign out_different = in ^ in_shifted;

endmodule
