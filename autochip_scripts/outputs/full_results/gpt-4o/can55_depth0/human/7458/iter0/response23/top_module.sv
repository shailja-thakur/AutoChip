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

    // Intermediate signals for the AND gate outputs
    wire and1, and2, and3, and4;
    
    // 3-input AND gates
    assign and1 = p1a & p1b & p1c;
    assign and2 = p1d & p1e & p1f;
    
    // 2-input AND gates
    assign and3 = p2a & p2b;
    assign and4 = p2c & p2d;

    // OR gates to drive the outputs
    assign p1y = and1 | and2;
    assign p2y = and3 | and4;

endmodule
