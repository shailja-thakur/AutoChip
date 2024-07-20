module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    wire sop_part1;
    wire sop_part2;

    // SOP Expression: (c & d) | (~a & ~b & c)
    assign sop_part1 = c & d;
    assign sop_part2 = ~a & ~b & c;
    assign out_sop = sop_part1 | sop_part2;

    wire pos0;
    wire pos1;

    // POS Expression Part 1: c & (~b | d) & (~a | b)
    assign pos0 = c & (~b | d) & (~a | b);

    // POS Expression Part 2: c & (~b | d) & (~a | d)
    assign pos1 = c & (~b | d) & (~a | d);

    // Final POS Output based on equality check
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
