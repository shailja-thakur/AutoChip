module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Generate out_sop (Sum-of-Products)
    wire sop0 = c & d;
    wire sop1 = ~a & ~b & c;
    assign out_sop = sop0 | sop1;

    // Generate pos0 for out_pos (Product-of-Sums)
    wire pos0_part1 = c;
    wire pos0_part2 = (~b | d);
    wire pos0_part3 = (~a | b);
    wire pos0 = pos0_part1 & pos0_part2 & pos0_part3;

    // Generate pos1 for out_pos (Product-of-Sums)
    wire pos1_part1 = c;
    wire pos1_part2 = (~b | d);
    wire pos1_part3 = (~a | d);
    wire pos1 = pos1_part1 & pos1_part2 & pos1_part3;
    
    // Assign out_pos
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
