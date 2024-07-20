module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // SOP (Sum of Products) Form
    // Logic-1 for 2, 7, 15: (0010, 0111, 1111)
    // m(2): ~a b ~c ~d
    // m(7): ~a b c d
    // m(15): a b c d
    assign out_sop = (~a & b & ~c & d) | (~a & b & c & d) | (a & b & c & d);

    // POS (Product of Sums) Form
    // Logic-0 for 0, 1, 4, 5, 6, 9, 10, 13, 14: (0000, 0001, 0100, 0101, 0110, 1001, 1010, 1101, 1110)
    // M(0): a + b + c + d
    // M(1): a + b + c + ~d
    // M(4): a + ~b + c + d
    // M(5): a + ~b + c + ~d
    // M(6): a + ~b + ~c + d
    // M(9): ~a + b + ~c + d
    // M(10): ~a + b + ~c + ~d
    // M(13): ~a + ~b + c + ~d
    // M(14): ~a + ~b + ~c + d
    assign out_pos = (a | b | c | d) & (a | b | c | ~d) & (a | ~b | c | d) & 
                     (a | ~b | c | ~d) & (a | ~b | ~c | d) & (~a | b | ~c | d) & 
                     (~a | b | ~c | ~d) & (~a | ~b | c | ~d) & (~a | ~b | ~c | d);

endmodule
