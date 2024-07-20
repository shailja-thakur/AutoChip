module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

    localparam INDEX_WIDTH = 10; // Width of the index to select 4-bit block from 1024-bit input

    // Calculate the starting index of the 4-bit block in the input vector (in)
    wire [INDEX_WIDTH-1:0] index = sel * 4;

    // Extract the 4-bit block from the input vector (in) based on the calculated index
    assign out = in[index+3:index];

endmodule
