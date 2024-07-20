module top_module (
    input [3:0] in,
    output [2:0] out_both,
    output [3:0] out_any,
    output [3:0] out_different
);

    // Bitwise AND operation for out_both: in[2:0] & in[3:1]
    assign out_both = in[2:0] & in[3:1];

    // Bitwise OR operation for out_any: in[2:0] | in[3:1]
    assign out_any[2:0] = in[2:0] | in[3:1];
    assign out_any[3] = 1'b0; // Since out_any was originally of width 3:1, but we need to pad it to 4 bits to meet the output width requirements

    // Bitwise XOR operation for out_different
    assign out_different = in ^ {in[3:1], in[0]}; // Concatenating in[3:1] with in[0] 

endmodule
