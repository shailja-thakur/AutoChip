module top_module (
    input [2:0] in,
    output [1:0] out
);

wire [1:0] tmp1, tmp2;

assign tmp1 = (in[0] == 1'b1) + (in[1] == 1'b1);
assign tmp2 = (in[2] == 1'b1) + tmp1;
assign out = tmp2;

endmodule
