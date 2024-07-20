module flipflop_mux(
    input clk,
    input L,
    input D0,
    input D1,
    output reg Q
);

always @(posedge clk) begin
    if (L)
        Q <= D1;
    else
        Q <= D0;
end

endmodule
module top_module(
    input [2:0] r,
    input L,
    input clk,
    output [2:0] q
);

wire [2:0] D;

flipflop_mux u0 (
    .clk(clk),
    .L(L),
    .D0(q[1] ^ q[2]),
    .D1(r[0]),
    .Q(q[0])
);

flipflop_mux u1 (
    .clk(clk),
    .L(L),
    .D0(q[0]),
    .D1(r[1]),
    .Q(q[1])
);

flipflop_mux u2 (
    .clk(clk),
    .L(L),
    .D0(q[2]),
    .D1(r[2]),
    .Q(q[2])
);

endmodule
