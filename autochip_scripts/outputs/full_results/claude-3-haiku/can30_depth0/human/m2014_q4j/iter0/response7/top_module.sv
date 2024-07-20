module top_module (
    input [3:0] x,
    input [3:0] y,
    output [4:0] sum
);

wire c1, c2, c3;

fulladder fa0 (
    .a(x[0]),
    .b(y[0]),
    .c_in(1'b0),
    .s(sum[0]),
    .c_out(c1)
);

fulladder fa1 (
    .a(x[1]),
    .b(y[1]),
    .c_in(c1),
    .s(sum[1]),
    .c_out(c2)
);

fulladder fa2 (
    .a(x[2]),
    .b(y[2]),
    .c_in(c2),
    .s(sum[2]),
    .c_out(c3)
);

fulladder fa3 (
    .a(x[3]),
    .b(y[3]),
    .c_in(c3),
    .s(sum[3]),
    .c_out(sum[4])
);

endmodule
module fulladder (
    input a,
    input b,
    input c_in,
    output s,
    output c_out
);

assign s = a ^ b ^ c_in;
assign c_out = (a & b) | (a & c_in) | (b & c_in);

endmodule
