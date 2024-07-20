module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    // Shift the input vector by one bit to the right
    wire [99:0] shifted_in = {in[0], in[99:1]};

    // Perform bitwise AND operation to get out_both
    assign out_both = in & shifted_in[99:1];

    // Perform bitwise OR operation to get out_any
    assign out_any = in | shifted_in;

    // Perform bitwise XOR operation to get out_different
    assign out_different[99:1] = in[99:1] ^ shifted_in[98:0];
    assign out_different[0] = in[0] ^ shifted_in[99];
endmodule
