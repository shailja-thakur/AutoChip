module full_module (
    input [2:0] r,
    input L,
    input clk,
    output [2:0] q
);

    wire q0, q1, q2;

    top_module u0 (
        .clk(clk),
        .L(L),
        .q_in(q[2]),
        .r_in(r[0]),
        .Q(q0)
    );

    top_module u1 (
        .clk(clk),
        .L(L),
        .q_in(q[0]),
        .r_in(r[1]),
        .Q(q1)
    );

    top_module u2 (
        .clk(clk),
        .L(L),
        .q_in(q[1]),
        .r_in(r[2]),
        .Q(q2)
    );

    assign q = {q2, q1, q0};

endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

    wire d;  // Output from the mux

    always @(posedge clk) begin
        Q <= d;
    end

    assign d = L ? r_in : q_in;

endmodule
