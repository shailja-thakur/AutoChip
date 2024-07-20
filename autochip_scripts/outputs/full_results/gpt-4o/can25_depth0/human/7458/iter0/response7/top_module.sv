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

    wire and1_out1, and1_out2;
    wire and2_out1, and2_out2;

    assign and1_out1 = p1a & p1b & p1c; // First 3-input AND gate
    assign and1_out2 = p1d & p1e & p1f; // Second 3-input AND gate

    assign p1y = and1_out1 | and1_out2;  // OR gate for p1y

    assign and2_out1 = p2a & p2b;        // First 2-input AND gate
    assign and2_out2 = p2c & p2d;        // Second 2-input AND gate

    assign p2y = and2_out1 | and2_out2;  // OR gate for p2y

endmodule
