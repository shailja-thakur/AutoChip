module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    wire [98:0] shifted_in;

    assign shifted_in = {in[98:0], in[99]};  // Shift the input vector by one bit

    assign out_both = in[98:0] & shifted_in;  // Perform bitwise AND operation

    assign out_any = in | shifted_in;  // Perform bitwise OR operation

    assign out_different[0] = in[0] ^ shifted_in[98];  // Perform a specific XOR operation for the first bit

    assign out_different[99:1] = in[99:1] ^ shifted_in[99:1];  // Perform bitwise XOR operation for the remaining bits

endmodule
