module top_module(
    input x,
    input y,
    output z);

    // Intermediate wire for internal calculations
    wire intermediate_wire;

    // Assignments for the intermediate wire and output z
    assign intermediate_wire = x & y;
    assign z = (~x & ~y) | intermediate_wire;

endmodule
