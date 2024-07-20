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

    // Intermediate wires to hold the AND and OR results
    wire and_p1, or_p1, and_p2, or_p2;

    // Logical AND operation on the first three inputs for output p1y
    assign and_p1 = p1a & p1b & p1c;

    // Logical OR operation on the last three inputs for output p1y
    assign or_p1 = p1d | p1e | p1f;

    // Combining the AND and OR results for p1y
    assign p1y = and_p1 & or_p1;

    // Logical AND operation on the first two inputs for output p2y
    assign and_p2 = p2a & p2b;

    // Logical OR operation on the last two inputs for output p2y
    assign or_p2 = p2c | p2d;

    // Combining the AND and OR results for p2y
    assign p2y = and_p2 & or_p2;

endmodule
