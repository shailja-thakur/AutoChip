module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    assign out = (~a & ~b & ~c & ~d) | // minterm 0
                 (~a & ~b & ~c &  d) | // minterm 1
                 (~a & ~b &  b &  d) | // correct minterm 3 (was 2 in previous clause)
                 (~a &  b &  c & ~d) | // correct minterm 6 (was 4)
                 (~a &  b &  c &  d) | // minterm 7
                 ( a & ~b & ~c & ~d) | // minterm 8
                 ( a & ~b & ~c &  d) | // minterm 9
                 ( a &  b & ~c & ~d) | // correct minterm 12 (was 4)
                 ( a &  b &  c &  d);  // minterm 15

endmodule
