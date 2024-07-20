module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    assign out = (~a & ~b & ~c & ~d) |     // 0000
                 (~a & ~b & ~c &  d) |     // 0001
                 (~a &  b & ~c & ~d) |     // 0100 
                 (~a &  b &  c &  d) |     // 0111
                 ( a & ~b & ~c & ~d) |     // 1000
                 ( a & ~b & ~c &  d) |     // 1001
                 ( a &  b &  c & ~d) |     // 1110
                 ( a &  b & ~c &  d) |     // 1011
                 (~a &  b & ~c &  d) |     // 0101
                 ( a &  b & ~c & ~d) |     // 1100
                 ( a &  b &  c & ~d) |     // 1110
                 ( a & ~b &  c &  d);      // 1101

endmodule
