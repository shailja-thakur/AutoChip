module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    // Shift the input vector by one bit
    wire [99:0] in_shifted;
    assign in_shifted = {in[98:0], in[99]};

    // Perform bitwise AND operation
    assign out_both = in & in_shifted[99:1];

    // Perform bitwise OR operation
    assign out_any = in | in_shifted;

    // Perform bitwise XOR operation
    assign out_different[99:1] = in ^ in_shifted[99:1];
    assign out_different[0] = in[0] ^ in_shifted[99];

endmodule
