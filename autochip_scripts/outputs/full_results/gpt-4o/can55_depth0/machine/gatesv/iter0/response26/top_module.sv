module top_module (
    input [3:0] in,
    output [2:0] out_both,
    output [3:0] out_any,
    output [3:0] out_different
);
    // Bitwise AND operation, out_both is a 3-bit wide vector
    assign out_both = in[2:0] & in[3:1];

    // Bitwise OR operation, out_any is a 4-bit wide vector
    assign out_any = in[3:0] | {1'b0, in[3:1]};

    // Bitwise XOR operation, out_different is a 4-bit wide vector
    assign out_different = in ^ {1'b0, in[3:1]};

endmodule
