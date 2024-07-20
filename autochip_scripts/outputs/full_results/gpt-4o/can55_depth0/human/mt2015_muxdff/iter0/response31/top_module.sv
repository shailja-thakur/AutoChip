module sub_module (
    input clk,
    input L,
    input r_in,
    input q_in,
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
    input [2:0] r_in,
    output [2:0] Q
);
    wire q0, q1, q2;

    // Instantiating three submodules
    sub_module u0 (
        .clk(clk),
        .L(L),
        .r_in(r_in[0]),
        .q_in(q1 ^ q2),
        .q(Q[0])
    );

    sub_module u1 (
        .clk(clk),
        .L(L),
        .r_in(r_in[1]),
        .q_in(Q[0]),
        .q(Q[1])
    );

    sub_module u2 (
        .clk(clk),
        .L(L),
        .r_in(r_in[2]),
        .q_in(Q[1]),
        .q(Q[2])
    );
endmodule
