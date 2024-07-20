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

    wire p1_and1, p1_and2, p2_and1, p2_and2;

    // Three-input AND gate for p1
    assign p1_and1 = p1a & p1b & p1c;
    // Three-input AND gate for p1
    assign p1_and2 = p1d & p1e & p1f;
    // OR the two AND gates for p1
    assign p1y = p1_and1 | p1_and2;

    // Two-input AND gate for p2
    assign p2_and1 = p2a & p2b;
    // Two-input AND gate for p2
    assign p2_and2 = p2c & p2d;
    // OR the two AND gates for p2
    assign p2y = p2_and1 | p2_and2;

endmodule
