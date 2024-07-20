module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    wire not_a, not_b;
    wire and1, and2;
    wire pos0, pos1;

    // Generate intermediate signals
    assign not_a = ~a;
    assign not_b = ~b;

    // SOP expression: (cd + a'b'c)
    assign and1 = c & d;
    assign and2 = not_a & not_b & c;
    assign out_sop = and1 | and2;

    // POS expression
    assign pos0 = c & (not_b | d) & (not_a | b);
    assign pos1 = c & (not_b | d) & (not_a | d);

    // Ternary check for POS
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
