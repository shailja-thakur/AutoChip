module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

    localparam BLOCK_SIZE = 32;
    wire [BLOCK_SIZE-1:0] selected_block;

    assign selected_block = in[(sel+1)*BLOCK_SIZE-1 : sel*BLOCK_SIZE];
    assign out = selected_block[3:0];

endmodule
