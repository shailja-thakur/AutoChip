module top_module (
    input [3:0] in,
    output [2:0] out_both,
    output [3:0] out_any,
    output [3:0] out_different
);

    // Bitwise AND between in[2:0] and in[3:1]
    assign out_both = in[2:0] & in[3:1];

    // Bitwise OR between in[2:0] and in[3:1]
    assign out_any = in[2:0] | in[3:1];

    // Bitwise XOR between the full in vector and in[3:1], with in[0] preserved
    assign out_different = in ^ {in[2:0], in[0]};

endmodule
