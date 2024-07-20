module top_module (
    input [3:0] in,
    output [2:0] out_both,
    output [3:0] out_any,
    output [3:0] out_different
);

    // Bitwise AND operation, outputs 3 bits
    assign out_both = in[2:0] & in[3:1];

    // Bitwise OR operation, outputs 4 bits
    assign out_any = {in[3] | in[3], in[2] | in[1], in[1] | in[0], in[0] | in[3]};

    // Bitwise XOR operation, outputs 4 bits 
    assign out_different = in ^ {in[3:1], in[0]};

endmodule
