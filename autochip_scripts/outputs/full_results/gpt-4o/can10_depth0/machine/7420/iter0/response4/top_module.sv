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

    // AND gate for the first set of inputs
    wire p1_and_result;
    assign p1_and_result = p1a & p1b & p1c & p1d;
    
    // Invert the result for the p1y output
    assign p1y = ~p1_and_result;

    // AND gate for the second set of inputs
    wire p2_and_result;
    assign p2_and_result = p2a & p2b & p2c & p2d;
    
    // Invert the result for the p2y output
    assign p2y = ~p2_and_result;

endmodule
