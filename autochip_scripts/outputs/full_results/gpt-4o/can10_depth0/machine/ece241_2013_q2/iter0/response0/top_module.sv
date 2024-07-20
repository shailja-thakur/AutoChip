module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    wire and1, and2, not_a, not_b;
    wire pos0, pos1, pos_and1, pos_and2;

    // Helper gates
    assign not_a = ~a;
    assign not_b = ~b;

    // Sum of Products (SOP) expression
    assign and1 = c & d;
    assign and2 = not_a & not_b & c;
    assign out_sop = and1 | and2;

    // Product of Sums (POS) expression
    assign pos_and1 = c & (not_b | d) & (not_a | b);
    assign pos_and2 = c & (not_b | d) & (not_a | d);
    assign pos0 = pos_and1;
    assign pos1 = pos_and2;

    // Assign final output based on ternary expression
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
