module flipflop_mux (
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg q
);
    always @(posedge clk) begin
        if (L) begin
            q <= r_in;
        end else begin
            q <= q_in;
        end
    end
endmodule
module top_module (
    input clk,
    input L,
    input [2:0] r,
    output [2:0] q
);
    wire q0, q1, q2;

    flipflop_mux u0 (
        .clk(clk),
        .L(L),
        .q_in(q1 ^ q2),
        .r_in(r[0]),
        .q(q0)
    );

    flipflop_mux u1 (
        .clk(clk),
        .L(L),
        .q_in(q0),
        .r_in(r[1]),
        .q(q1)
    );

    flipflop_mux u2 (
        .clk(clk),
        .L(L),
        .q_in(q1),
        .r_in(r[2]),
        .q(q2)
    );

    assign q = {q2, q1, q0};
endmodule
