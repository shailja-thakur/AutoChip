module flipflop (
    input clk,
    input q_in,
    output reg Q
);

always @(posedge clk) begin
    Q <= q_in;
end

endmodule
module mux_2to1 (
    input S,
    input D0,
    input D1,
    output reg Y
);

always @(S) begin
    if (S == 0) begin
        Y <= D0;
    end else begin
        Y <= D1;
    end
end

endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

wire [2:0] q0, q1, q2;
wire [2:0] r0, r1, r2;

flipflop ff0 (
    .clk(clk),
    .q_in(r_in),
    .Q(q0[0])
);

flipflop ff1 (
    .clk(clk),
    .q_in(q0[2]),
    .Q(q0[1])
);

flipflop ff2 (
    .clk(clk),
    .q_in(q0[1]),
    .Q(q0[2])
);

flipflop ff3 (
    .clk(clk),
    .q_in(D0[2]),
    .Q(r0[0])
);

flipflop ff4 (
    .clk(clk),
    .q_in(r0[2]),
    .Q(r0[1])
);

flipflop ff5 (
    .clk(clk),
    .q_in(r0[1]),
    .Q(r0[2])
);

mux_2to1 mux0 (
    .S(L),
    .D0(r_in),
    .D1(q0[0]),
    .Y(q1[0])
);

mux_2to1 mux1 (
    .S(L),
    .D0(q0[2]),
    .D1(q1[2]),
    .Y(q1[1])
);

mux_2to1 mux2 (
    .S(L),
    .D0(q0[1]),
    .D1(q1[1]),
    .Y(q1[2])
);

mux_2to1 mux3 (
    .S(L),
    .D0(q1[0]),
    .D1(q2[0]),
    .Y(q2[1])
);

mux_2to1 mux4 (
    .S(L),
    .D0(q1[2]),
    .D1(q2[2]),
    .Y(q2[0])
);

mux_2to1 mux5 (
    .S(L),
    .D0(q1[1]),
    .D1(q2[1]),
    .Y(Q)
);

endmodule
