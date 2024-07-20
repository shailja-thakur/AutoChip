module full_module (
    input [2:0] r,
    input L,
    input clk,
    output reg [2:0] q
);

top_module u0(
    .clk(clk),
    .L(L),
    .q_in(q[0]),
    .r_in(r[0]),
    .Q(q[0])
);

top_module u1(
    .clk(clk),
    .L(L),
    .q_in(q[1]),
    .r_in(r[1]),
    .Q(q[1])
);

top_module u2(
    .clk(clk),
    .L(L),
    .q_in({q[1], q[0], q[2]}),
    .r_in(r[2]),
    .Q(q[2])
);

endmodule
