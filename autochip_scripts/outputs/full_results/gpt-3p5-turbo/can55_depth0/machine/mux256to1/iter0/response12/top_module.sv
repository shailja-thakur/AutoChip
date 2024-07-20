module top_module (
    input [255:0] in,
    input [7:0] sel,
    output out
);

    wire [7:0] bit_index;

    assign bit_index = sel;

    assign out = in[bit_index];

endmodule
