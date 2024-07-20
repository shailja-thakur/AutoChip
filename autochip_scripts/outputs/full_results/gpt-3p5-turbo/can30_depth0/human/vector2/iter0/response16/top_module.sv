module top_module (
    input [31:0] in,
    output [31:0] out
);
    assign out = in[7:0]<<24 | in[15:8]<<16 | in[23:16]<<8 | in[31:24];
endmodule
