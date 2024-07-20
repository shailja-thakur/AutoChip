module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

    // Calculate the starting index of the 4-bit block in the input vector (in)
    // based on the selection vector (sel)
    wire [9:0] index = sel * 4;

    // Extract the 4-bit block from the input vector (in) starting from the calculated index
    // and assign it to the output vector (out)
    assign out = in[index +: 4];

endmodule
