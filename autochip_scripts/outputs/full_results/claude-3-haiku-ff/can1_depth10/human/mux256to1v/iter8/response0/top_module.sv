module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

localparam WORD_SIZE = 4;
localparam NUM_WORDS = 256;

assign out = in[(sel * WORD_SIZE + WORD_SIZE - 1) : (sel * WORD_SIZE)];

endmodule
