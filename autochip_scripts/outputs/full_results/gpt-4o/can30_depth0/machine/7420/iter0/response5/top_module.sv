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

    // AND operation on the first set of inputs
    wire p1_and;
    assign p1_and = p1a & p1b & p1c & p1d;
    // Invert the result for p1y
    assign p1y = ~p1_and;

    // AND operation on the second set of inputs
    wire p2_and;
    assign p2_and = p2a & p2b & p2c & p2d;
    // Invert the result for p2y
    assign p2y = ~p2_and;

endmodule
