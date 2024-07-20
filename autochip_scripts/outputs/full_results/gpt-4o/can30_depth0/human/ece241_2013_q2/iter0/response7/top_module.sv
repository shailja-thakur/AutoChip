module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Minimum Sum of Products (SOP) form
    // The output is 1 for the minterms 2, 7, 15.
    // Minterm 2: a'bcd'
    // Minterm 7: abcd'
    // Minterm 15: abcd
    assign out_sop = (~a & ~b & c & ~d) | (a & b & c & ~d) | (a & b & c & d);

    // Minimum Product of Sums (POS) form
    // The output is 0 for the maxterms 0, 1, 4, 5, 6, 9, 10, 13, 14.
    // Maxterm 0: (a + b + c + d)
    // Maxterm 1: (a + b + c + ~d)
    // Maxterm 4: (a + ~b + c + d)
    // Maxterm 5: (a + ~b + c + ~d)
    // Maxterm 6: (a + ~b + ~c + d)
    // Maxterm 9: (~a + b + c + ~d)
    // Maxterm 10: (~a + b + ~c + d)
    // Maxterm 13: (~a + ~b + c + d)
    // Maxterm 14: (~a + ~b + c + ~d)
    assign out_pos = (a | b | c | d) & (a | b | c | ~d) & (a | ~b | c | d) & (a | ~b | c | ~d) &
                      (a | ~b | ~c | d) & (~a | b | c | ~d) & (~a | b | ~c | d) & (~a | ~b | c | d) & 
                      (~a | ~b | c | ~d);

endmodule
