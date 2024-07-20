module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Minimum Sum-Of-Products (SOP) form
    // SOP for numbers 2 (0010), 7 (0111), and 15 (1111)
    assign out_sop = (~a & ~b & c & ~d) | (~a & b & c & d) | (a & b & c & d);

    // Minimum Product-Of-Sums (POS) form
    // POS for the complement of the given 9 conditions (numbers 0 (0000), 1 (0001), 4 (0100), 5 (0101), 6 (0110), 9 (1001), 10 (1010), 13 (1101), 14 (1110))
    // We need to invert the specified SOP minterms for POS form
    assign out_pos = (a | b | ~c | d) & (a | ~b | ~c | ~d) & (a | ~b | c | d);

endmodule
