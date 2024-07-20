module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Minimum sum-of-products (SOP) form
    // 2: 0010 -> ~a & ~b & c & ~d
    // 7: 0111 -> ~a & b & c & d
    // 15: 1111 -> a & b & c & d
    assign out_sop = (~a & ~b & c & ~d) | (~a & b & c & d) | (a & b & c & d);

    // Minimum product-of-sums (POS) form
    // !(2: 0010 -> ~a & ~b & c & ~d) = (a | b | ~c | d)
    // !(7: 0111 -> ~a & b & c & d) = (a | ~b | ~c | ~d)
    // !(15: 1111 -> a & b & c & d) = (~a | ~b | ~c | ~d)
    assign out_pos = (a | b | ~c | d) & (a | ~b | ~c | ~d) & (~a | ~b | ~c | ~d);

endmodule
