module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    assign out = (~a & ~b & ~c & ~d) | // 0000
                 (~a & ~b & ~c &  d) | // 0001
                 (~a &  b & ~c & ~d) | // 0010
                 (~a &  b & ~c &  d) | // 0011
                 (~a &  b &  c &  d) | // 0111
                 ( a & ~b & ~c & ~d) | // 1000
                 ( a & ~b &  c &  d) | // 1011
                 ( a &  b & ~c &  d) | // 1101
                 ( a &  b &  c & ~d) | // 1110
                 ( a &  b &  c &  d);  // 1111

endmodule
