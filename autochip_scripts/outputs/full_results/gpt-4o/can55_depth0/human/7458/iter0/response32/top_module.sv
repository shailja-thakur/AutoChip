module top_module(
    input p1a, 
    input p1b, 
    input p1c, 
    input p1d,
    input p1e,
    input p1f,
    input p2a, 
    input p2b, 
    input p2c, 
    input p2d, 
    output p1y, 
    output p2y
);

    // Intermediate wires for AND gate outputs
    wire and1_out_1, and1_out_2;
    wire and2_out_1, and2_out_2;
    
    // AND gates for p1y
    assign and1_out_1 = p1a & p1b & p1c;
    assign and1_out_2 = p1d & p1e & p1f;
    assign p1y = and1_out_1 | and1_out_2;
    
    // AND gates for p2y
    assign and2_out_1 = p2a & p2b;
    assign and2_out_2 = p2c & p2d;
    assign p2y = and2_out_1 | and2_out_2;

endmodule
