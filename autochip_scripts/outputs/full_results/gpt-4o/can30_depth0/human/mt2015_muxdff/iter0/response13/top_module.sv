module top_module(
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
module full_module(
    input [2:0] r,
    input L,
    input clk,
    output [2:0] q
);

wire q1, q2, q3;

top_module tm0(
    .clk(clk),
    .L(L),
    .q_in(q[1] ^ q[2]),
    .r_in(r[0]),
    .Q(q1)
);

top_module tm1(
    .clk(clk),
    .L(L),
    .q_in(q[0]),
    .r_in(r[1]),
    .Q(q2)
);

top_module tm2(
    .clk(clk),
    .L(L),
    .q_in(q[2]),
    .r_in(r[2]),
    .Q(q3)
);

assign q = {q3, q2, q1};

endmodule
