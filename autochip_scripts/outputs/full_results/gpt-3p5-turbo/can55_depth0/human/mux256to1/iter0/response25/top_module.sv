module top_module (
    input [255:0] in,
    input [7:0] sel,
    output out
);

    wire [7:0] sel_extended;
    assign sel_extended = sel >> 3;

    wire [255:0] in_selected;
    assign in_selected = {8'b0, in} & (256'hFF << sel_extended);

    wire out_selected;
    assign out_selected = in_selected[255];

    assign out = out_selected;

endmodule
