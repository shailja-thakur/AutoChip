module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

localparam WORD_SIZE = 4;
localparam NUM_WORDS = 256;

wire [WORD_SIZE-1:0] selected_word;

assign selected_word = in[(sel * WORD_SIZE + WORD_SIZE - 1) : (sel * WORD_SIZE)];
assign out = selected_word;

endmodule
