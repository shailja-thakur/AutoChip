module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);
    
    wire not_a, not_b;
    wire sop_part1, sop_part2;

    // Generate the NOT of inputs a and b
    assign not_a = ~a;
    assign not_b = ~b;

    // SOP Expression: (c & d) | (~a & ~b & c)
    assign sop_part1 = c & d;
    assign sop_part2 = not_a & not_b & c;
    assign out_sop = sop_part1 | sop_part2;

    // POS Expression
    wire pos0, pos1;
    wire or_part1, or_part2, or_part3, not_a_and_d;

    // Generate intermediate OR parts
    assign or_part1 = not_b | d;
    assign or_part2 = not_a | b;
    assign or_part3 = not_a | d;

    // Generate AND parts for POS expression
    assign pos0 = c & or_part1 & or_part2;
    assign not_a_and_d = not_a | d;
    assign pos1 = c & or_part1 & not_a_and_d;

    // Ternary expression for out_pos
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
