module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    // Shift the input vector by 1 bit
    wire [99:0] in_shifted;
    assign in_shifted = {in[98:0], 1'b0};

    // Generate the output signals
    assign out_both = in & in_shifted;
    assign out_any = in | in_shifted;
    assign out_different = in ^ in_shifted;

    // Handle the first bit of out_different
    assign out_different[0] = in[99] ^ in_shifted[99];

endmodule
