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
    // Intermediate wires for AND gate outputs
    wire and1_out;
    wire and2_out;
    
    // AND operations for each set of inputs
    assign and1_out = p1a & p1b & p1c & p1d;
    assign and2_out = p2a & p2b & p2c & p2d;
    
    // Inverted outputs
    assign p1y = ~and1_out;
    assign p2y = ~and2_out;
    
endmodule
