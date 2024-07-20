module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

wire [3:0] mux_out;

assign mux_out = in[(sel*4+3):(sel*4)];

assign out = mux_out;

endmodule
