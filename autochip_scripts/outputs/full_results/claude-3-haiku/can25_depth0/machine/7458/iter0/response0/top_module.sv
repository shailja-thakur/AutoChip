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

    // First output: logical AND of the first three inputs, logical OR of the last three inputs
    assign p1y = (p1a & p1b & p1c) | (p1d | p1e | p1f);

    // Second output: logical AND of the first two inputs, logical OR of the last two inputs
    assign p2y = (p2a & p2b) | (p2c | p2d);

endmodule
