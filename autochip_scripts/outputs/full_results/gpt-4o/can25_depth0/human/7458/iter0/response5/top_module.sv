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

    // Intermediate wires for AND gate outputs
    wire and1_out, and2_out, and3_out, and4_out;
    
    // First set of AND gates
    assign and1_out = p1a & p1b & p1c;
    assign and2_out = p1d & p1e & p1f;
    
    // Output p1y is the OR of the first two AND gates
    assign p1y = and1_out | and2_out;

    // Second set of AND gates
    assign and3_out = p2a & p2b;
    assign and4_out = p2c & p2d;
    
    // Output p2y is the OR of the second two AND gates
    assign p2y = and3_out | and4_out;

endmodule
