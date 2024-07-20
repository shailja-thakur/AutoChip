module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // SOP (Sum of Products) form: 2, 7, and 15
    // 2 -> 0010
    // 7 -> 0111
    // 15 -> 1111
    assign out_sop = (~a & ~b & c & ~d) | (a & b & c & d) | (~a & b & c & d);

    // POS (Product of Sums) form: 0, 1, 4, 5, 6, 9, 10, 13, 14
    // (a + b + c + d) * (a + b + c + ~d) * (a + ~b + c + ~d) * (a + ~b + ~c + d) * (a + ~b + ~c + ~d) *
    // (~a + b + c + d) * (~a + b + ~c + ~d) * (~a + ~b + c + d) * (~a + ~b + c + ~d) 
    assign out_pos = (a | b | c | d) & (a | b | c | ~d) & (a | ~b | c | ~d) & (a | ~b | ~c | d) &
                     (a | ~b | ~c | ~d) & (~a | b | c | d) & (~a | b | ~c | ~d) &
                     (~a | ~b | c | d) & (~a | ~b | c | ~d);

endmodule
