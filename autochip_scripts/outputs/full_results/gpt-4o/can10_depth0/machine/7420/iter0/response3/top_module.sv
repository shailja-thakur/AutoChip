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

    wire and_p1;
    wire and_p2;

    // AND operation on first set of inputs
    assign and_p1 = p1a & p1b & p1c & p1d;
    // AND operation on second set of inputs
    assign and_p2 = p2a & p2b & p2c & p2d;

    // Inverted outputs
    assign p1y = ~and_p1;
    assign p2y = ~and_p2;

endmodule
