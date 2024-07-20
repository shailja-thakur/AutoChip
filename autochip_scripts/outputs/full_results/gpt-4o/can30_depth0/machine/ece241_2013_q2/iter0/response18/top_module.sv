module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Generate Sum-of-Products (SOP) expression
    wire sop_term1 = c & d;
    wire sop_term2 = ~a & ~b & c;
    assign out_sop = sop_term1 | sop_term2;

    // Generate Product-of-Sums (POS) expression
    wire pos_term1_part1 = ~b | d;
    wire pos_term1_part2 = ~a | b;
    wire pos1 = c & pos_term1_part1 & pos_term1_part2;

    wire pos_term2_part2 = ~a | d;
    wire pos0 = c & pos_term1_part1 & pos_term2_part2;

    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
