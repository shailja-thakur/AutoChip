module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

    localparam BLOCK_SIZE = 4;
    wire [BLOCK_SIZE-1:0] selected_block;
    
    // Calculate the starting index of the 4-bit block in the input vector
    wire [9:0] start_index = sel * BLOCK_SIZE;
    
    // Extract the 4-bit block from the input vector
    assign selected_block = in[start_index +: BLOCK_SIZE];
    
    // Assign the selected block to the output
    assign out = selected_block;

endmodule
