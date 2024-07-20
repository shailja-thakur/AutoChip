module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    wire [99:0] in_shifted;

    // Create the shifted version of the input signal
    assign in_shifted = {in[98:0], 1'b0};

    // Generate the out_both signal (bitwise AND)
    assign out_both = in[99:1] & in_shifted[99:1];

    // Generate the out_any signal (bitwise OR)
    assign out_any = in | in_shifted;

    // Generate the out_different signal (bitwise XOR)
    assign out_different = in ^ {in[0], in[99:1]};

endmodule
