module top_module (
    input [3:0] in,
    output [2:0] out_both,
    output [3:0] out_any,
    output [3:0] out_different
);

    // Bitwise AND operation result (3-bit)
    assign out_both = in[2:0] & in[3:1];

    // Bitwise OR operation result (4-bit)
    assign out_any = in | {in[2:0], in[3]};

    // Bitwise XOR operation result (4-bit)
    assign out_different = in ^ {in[2:0], in[0]};

endmodule
