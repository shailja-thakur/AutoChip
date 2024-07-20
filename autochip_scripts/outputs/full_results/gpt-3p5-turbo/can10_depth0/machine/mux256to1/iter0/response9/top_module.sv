module top_module (
    input [255:0] in,
    input [7:0] sel,
    output out
);

wire [7:0] selected_index;

assign selected_index = sel;

assign out = in[selected_index];

endmodule
