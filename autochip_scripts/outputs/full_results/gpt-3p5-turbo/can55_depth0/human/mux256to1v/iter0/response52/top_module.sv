module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

wire [255:0] in_sel;

assign in_sel = in[(sel*4+3):(sel*4)];

assign out = in_sel;

endmodule
