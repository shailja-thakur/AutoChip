module flipflop_mux (
    input clk,
    input L,
    input q_in,
    input r_in,
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
module top_module(
    input clk,
    input L,
    input [2:0] r,
    output [2:0] q
);

wire q0_next, q1_next, q2_next;

assign q0_next = q[1] ^ q[2];
assign q1_next = q[0];
assign q2_next = q[2];

flipflop_mux u0 (
    .clk(clk),
    .L(L),
    .q_in(q1_next),
    .r_in(r[0]),
    .Q(q[0])
);

flipflop_mux u1 (
    .clk(clk),
    .L(L),
    .q_in(q0_next),
    .r_in(r[1]),
    .Q(q[1])
);

flipflop_mux u2 (
    .clk(clk),
    .L(L),
    .q_in(q0_next),
    .r_in(r[2]),
    .Q(q[2])
);

endmodule
