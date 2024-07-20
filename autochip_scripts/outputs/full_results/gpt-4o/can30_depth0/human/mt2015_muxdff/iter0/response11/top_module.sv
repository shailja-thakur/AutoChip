module sub_module(
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
    wire q0, q1, q2;

    sub_module u0(
        .clk(clk),
        .L(L),
        .q_in(q2 ^ q1),
        .r_in(r[0]),
        .Q(q[0])
    );

    sub_module u1(
        .clk(clk),
        .L(L),
        .q_in(q[0]),
        .r_in(r[1]),
        .Q(q[1])
    );

    sub_module u2(
        .clk(clk),
        .L(L),
        .q_in(q[1]),
        .r_in(r[2]),
        .Q(q[2])
    );
endmodule
