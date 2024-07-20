module top_module (
    input [255:0] in,
    input [7:0] sel,
    output  out
);

    wire [7:0] in_sel;
    assign in_sel = in[sel];
    assign out = in_sel[7];

endmodule
