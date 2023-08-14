module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
);

    wire [3:0] D;
    wire [3:0] Q;
    wire CLK;
    wire E;
    wire L;
    wire W;

    MUXDFF DFF1 (
        .D(D),
        .Q(Q),
        .CLK(CLK),
        .E(E),
        .L(L),
        .W(W)
    );

    MUXDFF DFF2 (
        .D(Q),
        .Q(Q[1:0]),
        .CLK(CLK),
        .E(E),
        .L(L),
        .W(W)
    );

    MUXDFF DFF3 (
        .D(Q[1:0]),
        .Q(Q[2:1]),
        .CLK(CLK),
        .E(E),
        .L(L),
        .W(W)
    );

    MUXDFF DFF4 (
        .D(Q[2:1]),
        .Q(Q[3:2]),
        .CLK(CLK),
        .E(E),
        .L(L),
        .W(W)
    );

    assign LEDR = Q;

endmodule