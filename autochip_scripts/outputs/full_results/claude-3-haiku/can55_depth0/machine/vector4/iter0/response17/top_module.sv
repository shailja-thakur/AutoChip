module top_module (
    input [7:0] in,
    output [31:0] out
);

assign out = {out[31:8], in};

endmodule
