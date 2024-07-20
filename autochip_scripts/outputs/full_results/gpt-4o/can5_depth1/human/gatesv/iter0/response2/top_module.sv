module top_module (
    input [3:0] in,
    output [2:0] out_both,
    output [3:1] out_any,
    output [3:0] out_different
);

    // out_both[2] should be 1 if both in[2] and in[3] are 1, out_both[1] for in[1] and in[2], out_both[0] for in[0] and in[1]
    assign out_both[2] = in[2] & in[3];
    assign out_both[1] = in[1] & in[2];
    assign out_both[0] = in[0] & in[1];

    // out_any[3] should be 1 if either in[3] or in[2] is 1, out_any[2] for in[2] and in[1], out_any[1] for in[1] and in[0]
    assign out_any[3] = in[3] | in[2];
    assign out_any[2] = in[2] | in[1];
    assign out_any[1] = in[1] | in[0];

    // out_different[3] should be 1 if in[3] is different from in[0] (wraps around)
    // out_different[2] for in[2] and in[3], out_different[1] for in[1] and in[2], out_different[0] for in[0] and in[1]
    assign out_different[3] = in[3] ^ in[0];
    assign out_different[2] = in[2] ^ in[3];
    assign out_different[1] = in[1] ^ in[2];
    assign out_different[0] = in[0] ^ in[1];

endmodule
