module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Minimum Sum-Of-Products (SOP) form for output
    assign out_sop = (~a & ~b & c & ~d) | (~a & b & c & d) | (a & b & c & d); // 2, 7, 15

    // Minimum Product-Of-Sums (POS) form for output
    assign out_pos = (a | ~b | ~c | d) & (a | b | ~c | ~d) & (a | b | c | ~d); // same numbers excluded: 0, 1, 4, 5, 6, 9, 10, 13, 14

endmodule
