module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    // Shift the input vector by 1 bit
    wire [99:0] in_shifted;
    assign in_shifted = {in[98:0], 1'b0};

    // Perform bitwise AND, OR, and XOR operations
    assign out_both = in & in_shifted[99:1];
    assign out_any = in | in_shifted;
    assign out_different = in ^ in_shifted;

    // Generate the first bit of out_different
    assign out_different[0] = in[0] ^ in_shifted[99];

endmodule
