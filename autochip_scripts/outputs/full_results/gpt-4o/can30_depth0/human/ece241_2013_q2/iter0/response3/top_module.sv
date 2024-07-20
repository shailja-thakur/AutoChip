module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Sum of Products (SOP) form: covers minterms for 2, 7, and 15
    assign out_sop = (~a & ~b & c & ~d) | (a & b & c & ~d) | (a & b & c & d);

    // Product of Sums (POS) form: covers maxterms for 0, 1, 4, 5, 6, 9, 10, 13, and 14
    assign out_pos = (b | ~c | d) & (~a | ~b | ~c) & (~b | c | d);

endmodule
