module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // SOP (Sum of Products) form:
    // out_sop = (a'b'cd) + (ab'cd') + (abcd)
    assign out_sop = (~a & ~b & c & d) | (a & ~b & c & ~d) | (a & b & c & d);

    // POS (Product of Sums) form:
    // out_pos = (a + b + ~c + ~d) (a + ~b + ~c + d) (~a + ~b + c + d)
    assign out_pos = (a | b | ~c | ~d) & (a | ~b | ~c | d) & (~a | ~b | c | d);

endmodule
