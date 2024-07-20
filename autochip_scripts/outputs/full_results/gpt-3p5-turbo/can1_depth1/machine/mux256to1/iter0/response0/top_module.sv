module top_module (
    input [255:0] in,
    input [7:0] sel,
    output  out
);

    wire [7:0] index;
    wire selected_bit;

    assign index = sel;

    assign selected_bit = in[index];

    assign out = selected_bit;

endmodule
