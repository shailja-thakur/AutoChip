module top_module(
    input p1a,
    input p1b,
    input p1c,
    input p1d,
    input p1e,
    input p1f,
    output p1y,
    input p2a,
    input p2b,
    input p2c,
    input p2d,
    output p2y
);

    wire p1g1, p1g2, p2g1, p2g2;

    // 3-input AND gate for p1y
    assign p1g1 = p1a & p1b & p1c;
    assign p1g2 = p1d & p1e & p1f;
    assign p1y = p1g1 | p1g2;

    // 2-input AND gate for p2y
    assign p2g1 = p2a & p2b;
    assign p2g2 = p2c & p2d;
    assign p2y = p2g1 | p2g2;

endmodule
