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

    // Output p1y is the result of a logical AND on the first three inputs and a logical OR on the last three inputs
    assign p1y = (p1a & p1b & p1c) | (p1d | p1e | p1f);

    // Output p2y is the result of a logical AND on the first two inputs and a logical OR on the last two inputs
    assign p2y = (p2a & p2b) | (p2c | p2d);

endmodule
