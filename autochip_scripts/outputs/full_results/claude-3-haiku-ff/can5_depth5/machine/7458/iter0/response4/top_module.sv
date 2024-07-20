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

    // p1y is the result of a logical AND operation on the first three inputs (p1a, p1b, and p1c)
    // and a logical OR operation on the last three inputs (p1d, p1e, and p1f)
    assign p1y = (p1a & p1b & p1c) | (p1d | p1e | p1f);

    // p2y is the result of a logical AND operation on the first two inputs (p2a and p2b)
    // and a logical OR operation on the last two inputs (p2c and p2d)
    assign p2y = (p2a & p2b) | (p2c | p2d);

endmodule
