module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Sum-of-Products (SOP) logic
    wire sop_part1, sop_part2;
    assign sop_part1 = c & d;
    assign sop_part2 = (~a) & (~b) & c;
    assign out_sop = sop_part1 | sop_part2;

    // Product-of-Sums (POS) logic
    wire pos0, pos1;
    assign pos0 = c & ((~b) | d) & ((~a) | b);
    assign pos1 = c & ((~a) | d) & ((~b) | d);
    assign out_pos = pos0 & pos1;

endmodule
