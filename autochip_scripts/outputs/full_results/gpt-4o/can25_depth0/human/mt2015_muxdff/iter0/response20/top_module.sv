module mux_dff(
    input clk,
    input L,
    input d0,
    input d1,
    output reg q
);
    always @(posedge clk) begin
        if (L)
            q <= d0;
        else
            q <= d1;
    end
endmodule
module top_module(
    input clk,
    input L,
    input [2:0] r,
    output [2:0] q
);
    wire q_temp_0, q_temp_1, q_temp_2;

    mux_dff u0 (
        .clk(clk),
        .L(L),
        .d0(r[0]),
        .d1(q_temp_2 ^ q_temp_1),
        .q(q_temp_0)
    );

    mux_dff u1 (
        .clk(clk),
        .L(L),
        .d0(r[1]),
        .d1(q[0]),
        .q(q_temp_1)
    );

    mux_dff u2 (
        .clk(clk),
        .L(L),
        .d0(r[2]),
        .d1(q[2]),
        .q(q_temp_2)
    );

    assign q = {q_temp_2, q_temp_1, q_temp_0};
endmodule
