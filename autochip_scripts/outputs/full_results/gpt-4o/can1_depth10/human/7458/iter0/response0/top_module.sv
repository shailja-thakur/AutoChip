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

    // Intermediate signals for AND gates
    wire and1_out, and2_out, and3_out, and4_out;
    
    // 3-input AND gates for p1y output
    assign and1_out = p1a & p1b & p1c;
    assign and2_out = p1d & p1e & p1f;
    
    // OR gate to combine the outputs of the 3-input AND gates for p1y
    assign p1y = and1_out | and2_out;
    
    // 2-input AND gates for p2y output
    assign and3_out = p2a & p2b;
    assign and4_out = p2c & p2d;
    
    // OR gate to combine the outputs of the 2-input AND gates for p2y
    assign p2y = and3_out | and4_out;

endmodule
