module top_module (
    input [2:0] in,
    output [1:0] out
);

wire [1:0] tmp1, tmp2;

assign tmp1[0] = in[0] | in[2];
assign tmp1[1] = in[1] | in[2];

assign tmp2[0] = tmp1[0] | tmp1[1];
assign tmp2[1] = tmp1[1];

assign out = tmp2;

endmodule
