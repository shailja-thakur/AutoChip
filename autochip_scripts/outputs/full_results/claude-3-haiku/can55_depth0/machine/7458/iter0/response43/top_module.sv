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

    // Logic for p1y
    wire p1_and = p1a & p1b & p1c;
    wire p1_or = p1d | p1e | p1f;
    assign p1y = p1_and & p1_or;

    // Logic for p2y
    wire p2_and = p2a & p2b;
    wire p2_or = p2c | p2d;
    assign p2y = p2_and | p2_or;

endmodule
