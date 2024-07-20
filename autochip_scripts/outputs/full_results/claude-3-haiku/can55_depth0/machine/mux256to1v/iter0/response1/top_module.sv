module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

    localparam BLOCK_SIZE = 4;
    
    wire [BLOCK_SIZE-1:0] block;
    
    // Calculate the starting index of the 4-bit block based on the selection vector (sel)
    assign block = in[(sel*BLOCK_SIZE) +: BLOCK_SIZE];
    
    // Assign the 4-bit block to the output vector (out)
    assign out = block;

endmodule
