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

    // AND operation on the first set of inputs (p1a, p1b, p1c, p1d)
    wire and_p1;
    assign and_p1 = p1a & p1b & p1c & p1d;
    
    // AND operation on the second set of inputs (p2a, p2b, p2c, p2d)
    wire and_p2;
    assign and_p2 = p2a & p2b & p2c & p2d;
    
    // Inverted output for p1y
    assign p1y = ~and_p1;
    
    // Inverted output for p2y
    assign p2y = ~and_p2;

endmodule
