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

    wire and1_result, and2_result;

    // AND gate for first set of inputs.
    assign and1_result = p1a & p1b & p1c & p1d;
    // Invert the result.
    assign p1y = ~and1_result;

    // AND gate for second set of inputs.
    assign and2_result = p2a & p2b & p2c & p2d;
    // Invert the result.
    assign p2y = ~and2_result;

endmodule
