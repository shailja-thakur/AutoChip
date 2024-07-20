module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

// Sum-of-Products (SOP) form
assign out_sop =
    (~a & ~b & ~c & ~d) | // 0
    (~a & ~b &  c & ~d) | // 2
    ( a &  b &  c &  d) | // 7
    ( a &  b &  c & ~d) | // 14
    ( a &  b & ~c &  d) | // 13
    ( a & ~b &  c &  d) | // 11
    ( a & ~b & ~c &  d) | // 12
    ( a & ~b & ~c & ~d); // 8

// Product-of-Sums (POS) form
assign out_pos =
    (a | b | c | d) & // 0
    (a | b | c | ~d) & // 1
    (a | b | ~c | d) & // 4
    (a | b | ~c | ~d) & // 5
    (a | ~b | c | d) & // 6
    (~a | b | c | ~d) & // 9
    (~a | b | ~c | d) & // 10
    (~a | ~b | c | d) & // 13
    (~a | ~b | ~c | d); // 14
endmodule
