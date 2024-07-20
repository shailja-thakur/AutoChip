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
    wire and1_output;
    wire and2_output;
    wire and3_output;
    wire and4_output;

    // AND gates
    assign and1_output = p1a & p1b & p1c;  // Three-input AND gate
    assign and2_output = p1d & p1e & p1f;  // Three-input AND gate
    assign and3_output = p2a & p2b;        // Two-input AND gate
    assign and4_output = p2c & p2d;        // Two-input AND gate

    // OR gates
    assign p1y = and1_output | and2_output; // OR gate for first output
    assign p2y = and3_output | and4_output; // OR gate for second output

endmodule
