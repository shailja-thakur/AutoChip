module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    assign out = (~a & ~b & ~c & ~d) | // 00 00
                 (~a & ~b & ~c &  d) | // 00 01
                 (~a & ~b &  b & ~d) | // 01 00
                 (~a & b &  c &  d)  | // 01 11
                 ( a & ~b & ~c & ~d) | // 10 00
                 ( a & ~b & ~c &  d) | // 10 01
                 (~a &  b & ~c & ~d) | // 01 00
                 ( ~a & b & ~c &  d) | // 01 11
                 ( a &  b & ~c &  d) | // 11 01
                 ( a &  b &  c & ~d);  // 1110

endmodule
