module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
);

    wire [3:0] D;
    wire [3:0] Q;
    wire clk;
    wire E;
    wire L;
    wire w;

    MUXDFF muxdff0 (
        .D(D[0]),
        .Q(Q[0]),
        .S(KEY[0]),
        .R(SW[0]),
        .C(clk),
        .E(E)
    );

    MUXDFF muxdff1 (
        .D(D[1]),
        .Q(Q[1]),
        .S(KEY[1]),
        .R(SW[1]),
        .C(clk),
        .E(E)
    );

    MUXDFF muxdff2 (
        .D(D[2]),
        .Q(Q[2]),
        .S(KEY[2]),
        .R(SW[2]),
        .C(clk),
        .E(E)
    );

    MUXDFF muxdff3 (
        .D(D[3]),
        .Q(Q[3]),
        .S(KEY[3]),
        .R(SW[3]),
        .C(clk),
        .E(E)
    );

    assign LEDR[0] = Q[0];
    assign LEDR[1] = Q[1];
    assign LEDR[2] = Q[2];
    assign LEDR[3] = Q[3];

endmodule