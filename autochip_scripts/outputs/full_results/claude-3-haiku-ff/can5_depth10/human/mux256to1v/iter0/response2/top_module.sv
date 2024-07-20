module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

wire [3:0] temp;

assign temp = in[sel*4 +: 4];

assign out = temp;

endmodule
