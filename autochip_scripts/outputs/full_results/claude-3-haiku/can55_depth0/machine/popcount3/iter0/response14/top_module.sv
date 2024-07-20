module top_module (
    input [2:0] in,
    output [1:0] out
);

assign out = in[2:0] + 3'b000;

endmodule
