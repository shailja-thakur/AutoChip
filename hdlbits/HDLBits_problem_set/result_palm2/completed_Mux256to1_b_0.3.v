module top_module(
    input [255:0] in,
    input [7:0] sel,
    output out);

    wire [255:0] sel_mask = 1 << sel;
    assign out = in[sel_mask];

endmodule