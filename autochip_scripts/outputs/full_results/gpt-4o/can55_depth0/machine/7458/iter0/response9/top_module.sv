module top_module(
    input p1a, 
    input p1b, 
    input p1c, 
    input p1d,
    input p1e,
    input p1f,
    input p2a, 
    input p2b, 
    input p2c, 
    input p2d, 
    output p1y, 
    output p2y
);

    wire and1, or1;
    wire and2, or2;

    // Logical AND and OR for p1y
    assign and1 = p1a & p1b & p1c;
    assign or1 = p1d | p1e | p1f;
    assign p1y = and1 & or1;

    // Logical AND and OR for p2y
    assign and2 = p2a & p2b;
    assign or2 = p2c | p2d;
    assign p2y = and2 & or2;

endmodule
