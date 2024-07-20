module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

    localparam BLOCK_SIZE = 4;
    
    wire [BLOCK_SIZE-1:0] selected_block;
    
    // Calculate the starting index of the 4-bit block in the input vector (in)
    assign selected_block = in[(sel * BLOCK_SIZE) +: BLOCK_SIZE];
    
    // Assign the selected 4-bit block to the output vector (out)
    assign out = selected_block;

endmodule
