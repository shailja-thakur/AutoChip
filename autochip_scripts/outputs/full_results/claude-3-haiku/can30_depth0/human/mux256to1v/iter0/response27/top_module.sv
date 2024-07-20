module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

wire [3:0] selected_bits;

assign selected_bits = in[(sel * 4) +: 4];

assign out = selected_bits;

endmodule
