module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    wire and1, and2, not_a, not_b;
    wire pos0, pos1;

    // Calculate NOT gates
    assign not_a = ~a;
    assign not_b = ~b;

    // SOP Calculation: (c & d) | (~a & ~b & c)
    assign and1 = c & d;
    assign and2 = not_a & not_b & c;
    assign out_sop = and1 | and2;

    // POS Calculation: (c & (~b | d) & (~a | b)) & (c & (~a | d))
    assign pos0 = c & (not_b | d) & (not_a | b);
    assign pos1 = c & (not_a | d);
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
