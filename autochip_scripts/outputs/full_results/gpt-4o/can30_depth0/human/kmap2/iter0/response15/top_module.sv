module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);
    assign out = (~a & ~b & ~c & ~d) |
                 (~a & ~b & ~c &  d) |
                 (~a & ~b &  d & ~c) |
                 (~a & ~b &  d &  b) |
                 (~a &  b &  c & ~d) |
                 (~a &  b &  c &  d) |
                 ( a & ~b & ~c &  d) |
                 ( a & ~b &  c &  d) |
                 ( a &  b & ~c &  d) |
                 ( a &  b &  c & ~d) |
                 ( a &  b &  c &  d);
endmodule
