module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    // Perform bitwise AND operation to generate out_both
    assign out_both = in[99:1] & in[98:0];

    // Perform bitwise OR operation to generate out_any
    assign out_any = in;

    // Perform bitwise XOR operation to generate out_different
    assign out_different[99] = in[99] ^ in[98];
    assign out_different[98:0] = in[98:0] ^ in[99:1];

endmodule
