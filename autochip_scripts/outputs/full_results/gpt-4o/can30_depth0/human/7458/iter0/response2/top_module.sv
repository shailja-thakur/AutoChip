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

    wire and1_out, and2_out, and3_out, and4_out;

    // First AND gate for p1y
    assign and1_out = p1a & p1b & p1c;
    // Second AND gate for p1y
    assign and2_out = p1d & p1e & p1f;
    // OR gate for p1y
    assign p1y = and1_out | and2_out;

    // First AND gate for p2y
    assign and3_out = p2a & p2b;
    // Second AND gate for p2y
    assign and4_out = p2c & p2d;
    // OR gate for p2y
    assign p2y = and3_out | and4_out;

endmodule
