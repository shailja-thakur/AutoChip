module ff_and_mux (
    input clk,
    input L,
    input r_in,
    input q_in,
    output reg Q
);

always @(posedge clk) begin
    if (L) begin
        Q <= r_in;
    end else begin
        Q <= q_in;
    end
end

endmodule
module top_module (
    input [2:0] r,
    input L,
    input clk,
    output [2:0] q
);

ff_and_mux u0 (
    .clk(clk),
    .L(L),
    .r_in(r[0]),
    .q_in(q[1] ^ q[2]),
    .Q(q[0])
);

ff_and_mux u1 (
    .clk(clk),
    .L(L),
    .r_in(r[1]),
    .q_in(q[0]),
    .Q(q[1])
);

ff_and_mux u2 (
    .clk(clk),
    .L(L),
    .r_in(r[2]),
    .q_in(q[2]),
    .Q(q[2])
);

endmodule
