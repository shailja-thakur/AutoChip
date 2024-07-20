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

    // Intermediate wires for the AND gates' outputs
    wire and1_out, and2_out, and3_out, and4_out;

    // The first 3-input AND gate
    assign and1_out = p1a & p1b & p1c;
    // The second 3-input AND gate
    assign and2_out = p1d & p1e & p1f;
    // Combining the outputs of the two 3-input AND gates using an OR gate
    assign p1y = and1_out | and2_out;

    // The first 2-input AND gate
    assign and3_out = p2a & p2b;
    // The second 2-input AND gate
    assign and4_out = p2c & p2d;
    // Combining the outputs of the two 2-input AND gates using an OR gate
    assign p2y = and3_out | and4_out;

endmodule
