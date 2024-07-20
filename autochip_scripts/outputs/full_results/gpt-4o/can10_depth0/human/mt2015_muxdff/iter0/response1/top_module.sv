module flipflop_mux (
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
    input clk,
    input L,
    input [2:0] r,
    output [2:0] q
);
    wire q0, q1, q2;

    // Instantiating three flipflop_mux submodules
    flipflop_mux ffm0 (
        .clk(clk),
        .L(L),
        .r_in(r[0]),
        .q_in(q[1] ^ q[2]),
        .Q(q0)
    );

    flipflop_mux ffm1 (
        .clk(clk),
        .L(L),
        .r_in(r[1]),
        .q_in(q[0]),
        .Q(q1)
    );

    flipflop_mux ffm2 (
        .clk(clk),
        .L(L),
        .r_in(r[2]),
        .q_in(q[2]),
        .Q(q2)
    );

    assign q = {q2, q1, q0};
endmodule
