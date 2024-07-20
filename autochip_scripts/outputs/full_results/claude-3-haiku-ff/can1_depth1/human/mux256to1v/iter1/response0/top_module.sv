module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

wire [31:0] select_bits;

assign select_bits = in[(sel*4 + 3):(sel*4)];
assign out = select_bits;

endmodule
