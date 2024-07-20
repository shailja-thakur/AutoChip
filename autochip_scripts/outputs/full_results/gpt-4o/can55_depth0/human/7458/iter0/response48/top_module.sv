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

    // Intermediate wires for the outputs of the AND gates
    wire p1a_and_p1b_and_p1c;
    wire p1d_and_p1e_and_p1f;
    wire p2a_and_p2b;
    wire p2c_and_p2d;

    // AND gates
    assign p1a_and_p1b_and_p1c = p1a & p1b & p1c;
    assign p1d_and_p1e_and_p1f = p1d & p1e & p1f;
    assign p2a_and_p2b = p2a & p2b;
    assign p2c_and_p2d = p2c & p2d;

    // OR gates
    assign p1y = p1a_and_p1b_and_p1c | p1d_and_p1e_and_p1f; 
    assign p2y = p2a_and_p2b | p2c_and_p2d;

endmodule
