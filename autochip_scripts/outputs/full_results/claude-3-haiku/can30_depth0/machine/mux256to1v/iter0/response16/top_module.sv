module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

    wire [11:0] index;

    // Calculate the starting index of the 4-bit block in the input vector (in)
    assign index = sel * 4;

    // Extract the 4-bit block from the input vector (in) and assign it to the output vector (out)
    assign out = in[index +: 4];

endmodule
