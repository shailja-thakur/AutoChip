module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

    // Calculate starting index of 4-bit block
    wire [9:0] start_index = sel * 4;

    // Extract 4-bit block from input vector
    wire [3:0] out = in[start_index +: 4];

endmodule
