module flipflop_2to1(
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
module top_module(
    input clk,
    input L,
    input [2:0] r,
    output [2:0] q
);
    wire Q0, Q1, Q2;
    wire q_in0, q_in1, q_in2;

    // Instantiate submodules with the appropriate connections
    assign q_in0 = Q1 ^ Q2;
    assign q_in1 = Q0;
    assign q_in2 = Q2;

    flipflop_2to1 ff0(
        .clk(clk),
        .L(L),
        .r_in(r[0]),
        .q_in(q_in0),
        .Q(Q0)
    );

    flipflop_2to1 ff1(
        .clk(clk),
        .L(L),
        .r_in(r[1]),
        .q_in(q_in1),
        .Q(Q1)
    );

    flipflop_2to1 ff2(
        .clk(clk),
        .L(L),
        .r_in(r[2]),
        .q_in(q_in2),
        .Q(Q2)
    );

    assign q = {Q2, Q1, Q0};
endmodule
