module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

    // Calculating the starting bit index of the 4-bit block
    wire [9:0] index;
    assign index = sel * 4;

    // Extracting the 4-bit block from the input vector
    assign out = in[index +: 4];

endmodule
