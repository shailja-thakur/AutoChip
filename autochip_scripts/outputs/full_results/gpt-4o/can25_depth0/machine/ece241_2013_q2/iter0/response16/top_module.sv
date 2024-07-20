module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Calculate out_sop (Sum-of-Products)
    wire sop_part1 = c & d;
    wire sop_part2 = ~a & ~b & c;
    assign out_sop = sop_part1 | sop_part2;

    // Calculate out_pos (Product-of-Sums)
    wire pos0 = c & (~b | d) & (~a | b);
    wire pos1 = c & (~b | d) & (~a | d);
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
