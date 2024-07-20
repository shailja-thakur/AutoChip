module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

    // Calculate the starting index of the 4-bit block in the input vector (in)
    localparam INDEX_WIDTH = $clog2(1024);
    wire [INDEX_WIDTH-1:0] start_index = sel * 4;

    // Extract the 4-bit block from the input vector (in)
    assign out = in[start_index +: 4];

endmodule
