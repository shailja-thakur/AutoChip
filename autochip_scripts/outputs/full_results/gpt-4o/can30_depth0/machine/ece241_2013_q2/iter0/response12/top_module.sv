module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Intermediate wires
    wire sop_part1, sop_part2;
    wire pos0, pos1;

    // SOP part calculations
    assign sop_part1 = c & d;
    assign sop_part2 = (~a) & (~b) & c;

    // SOP output
    assign out_sop = sop_part1 | sop_part2;

    // POS part calculations
    assign pos0 = c & ((~b) | d) & ((~a) | b);
    assign pos1 = c & ((~a) | d);

    // POS output
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
