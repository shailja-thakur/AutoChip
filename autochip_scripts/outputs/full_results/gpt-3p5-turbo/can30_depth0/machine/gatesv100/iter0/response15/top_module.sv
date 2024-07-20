module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    wire [98:0] shifted_in;  // declare wire for shifted input

    assign shifted_in = {in[98:0], 1'b0};  // shift input by 1 bit

    assign out_both = in & shifted_in;  // perform bit-wise AND operation

    assign out_any = in | shifted_in;  // perform bit-wise OR operation

    assign out_different[0] = in[0] ^ shifted_in[99];  // perform bit-wise XOR operation for first bit

    assign out_different[99:1] = in[99:1] ^ shifted_in[98:0];  // perform bit-wise XOR operation for remaining bits

endmodule
