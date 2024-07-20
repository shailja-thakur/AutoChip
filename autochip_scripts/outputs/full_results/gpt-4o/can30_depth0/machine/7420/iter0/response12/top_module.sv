module top_module(
    input p1a,
    input p1b,
    input p1c,
    input p1d,
    output p1y,
    input p2a,
    input p2b,
    input p2c,
    input p2d,
    output p2y
);

    // AND gate for p1 inputs
    wire and_p1;
    assign and_p1 = p1a & p1b & p1c & p1d;
    assign p1y = ~and_p1;

    // AND gate for p2 inputs
    wire and_p2;
    assign and_p2 = p2a & p2b & p2c & p2d;
    assign p2y = ~and_p2;

endmodule
