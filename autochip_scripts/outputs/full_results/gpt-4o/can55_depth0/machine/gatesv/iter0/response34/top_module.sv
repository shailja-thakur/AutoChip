module top_module (
    input [3:0] in,
    output [2:0] out_both,
    output [3:0] out_any,
    output [3:0] out_different
);

    // Bitwise AND operation between bits 2:0 and bits 3:1
    assign out_both = in[2:0] & in[3:1];

    // Bitwise OR operation between bits 2:0 and bits 3:1
    assign out_any = { (in[2] | in[3]), (in[1] | in[2]), (in[0] | in[1]), (0 | in[0]) };

    // Bitwise XOR operation with special handling for bit 0
    assign out_different = in ^ {in[2:0], in[0]};

endmodule
