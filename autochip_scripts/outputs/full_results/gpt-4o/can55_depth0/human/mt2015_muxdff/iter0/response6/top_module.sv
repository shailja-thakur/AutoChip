module flipflop_mux(
    input clk,
    input L,
    input d,
    input r,
    output reg q
);

always @(posedge clk) begin
    if (L) begin
        q <= r;
    end else begin
        q <= d;
    end
end

endmodule
module full_module (
    input [2:0] r,
    input L,
    input clk,
    output [2:0] q
);

wire q0, q1, q2;

assign d0 = q1 ^ q2;
assign d1 = q0;
assign d2 = q2;

// Instantiation of the submodule three times
flipflop_mux u0(
    .clk(clk),
    .L(L),
    .d(d0),
    .r(r[0]),
    .q(q[0])
);

flipflop_mux u1(
    .clk(clk),
    .L(L),
    .d(d1),
    .r(r[1]),
    .q(q[1])
);

flipflop_mux u2(
    .clk(clk),
    .L(L),
    .d(d2),
    .r(r[2]),
    .q(q[2])
);

endmodule
