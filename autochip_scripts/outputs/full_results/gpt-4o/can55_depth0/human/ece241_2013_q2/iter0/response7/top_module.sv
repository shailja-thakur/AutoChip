module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Minimum Sum-of-Products (SOP) form
    // 2: 0 010;  2 = a'bcd'
    // 7: 0111;  7 = abcd
    // 15: 1111; 15 = abcd'
    assign out_sop = (~a & b & ~c & d) | (a & b & c & d) | (a & b & c & ~d);

    // Minimum Product-of-Sums (POS) form
    // invocations of non-occuring conditions are omitted
    // out_sop(y) : m2+m7+m15
    // out_pos(y) : (A+B+C'+D')(A+B+C+D)(A'+B+C+D)
    assign out_pos = (a | b | ~c | ~d) & (a | b | c | d) & (~a | b | c | d);

endmodule
