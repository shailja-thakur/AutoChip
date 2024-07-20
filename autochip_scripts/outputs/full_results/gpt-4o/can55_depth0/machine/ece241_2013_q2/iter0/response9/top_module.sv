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

    // Generate NOT gates
    assign not_a = ~a;
    assign not_b = ~b;

    // Generate AND gates for SOP
    assign and1 = c & d;
    assign and2 = not_a & not_b & c;

    // Generate SOP output
    assign out_sop = and1 | and2;

    // Generate AND gates and OR gates for POS
    assign pos0 = c & (not_b | d) & (not_a | b);
    assign pos1 = c & (not_b | d) & (not_a | d);

    // Generate POS output
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
