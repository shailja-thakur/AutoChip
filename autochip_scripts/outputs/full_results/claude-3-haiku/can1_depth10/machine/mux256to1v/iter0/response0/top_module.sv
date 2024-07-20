module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

    wire [3:0] selected_block;

    // Calculate the starting index of the 4-bit block in the input vector (in)
    localparam START_INDEX = sel * 4;

    // Extract the 4-bit block from the input vector (in)
    assign selected_block = in[START_INDEX +: 4];

    // Assign the extracted 4-bit block to the output vector (out)
    assign out = selected_block;

endmodule
