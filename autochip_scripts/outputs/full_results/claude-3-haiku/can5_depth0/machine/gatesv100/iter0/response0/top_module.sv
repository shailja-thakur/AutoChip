module top_module (
    input  [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    // Assign the shifted input signal
    wire [99:0] in_shift = {in[0], in[99:1]};

    // Compute the output signals
    assign out_both = in & in_shift;
    assign out_any  = in | in_shift;
    assign out_different = in ^ in_shift;

endmodule
