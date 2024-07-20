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
    wire mux0, mux1, mux2;

    assign mux0 = q1 ^ q2;
    assign mux1 = q0;
    assign mux2 = q1;

    flipflop_mux ff0 (
        .clk(clk),
        .L(L),
        .r_in(r[0]),
        .q_in(mux0),
        .Q(q[0])
    );

    flipflop_mux ff1 (
        .clk(clk),
        .L(L),
        .r_in(r[1]),
        .q_in(mux1),
        .Q(q[1])
    );

    flipflop_mux ff2 (
        .clk(clk),
        .L(L),
        .r_in(r[2]),
        .q_in(mux2),
        .Q(q[2])
    );

    assign q0 = q[0];
    assign q1 = q[1];
    assign q2 = q[2];
endmodule
