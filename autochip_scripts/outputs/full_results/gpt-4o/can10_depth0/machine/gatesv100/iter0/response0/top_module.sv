module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    // Shift the input signal by one bit to the right
    wire [99:0] in_shifted;
    assign in_shifted = {in[98:0], 1'b0};

    // Generate the out_both signal
    assign out_both = in[98:0] & in_shifted[99:1];

    // Generate the out_any signal
    assign out_any = in | {in[98:0], 1'b0};

    // Generate the out_different signal
    assign out_different = in ^ {in[98:0], in[99]};

endmodule
