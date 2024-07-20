module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

    assign q = ( ~a & ~b & ~c & ~d)  // 0 0 0 0 -> 1
             | ( ~a & ~b & ~c &  d)  // 0 0 0 1 -> 0
             | ( ~a & ~b &  c & ~d)  // 0 0 1 0 -> 0
             | ( ~a & ~b &  c &  d)  // 0 0 1 1 -> 1
             | ( ~a &  b & ~c & ~d)  // 0 1 0 0 -> 0
             | ( ~a &  b & ~c &  d)  // 0 1 0 1 -> 1
             | ( ~a &  b &  c & ~d)  // 0 1 1 0 -> 1
             | ( ~a &  b &  c &  d)  // 0 1 1 1 -> 0
             | (  a & ~b & ~c & ~d)  // 1 0 0 0 -> 0
             | (  a & ~b & ~c &  d)  // 1 0 0 1 -> 1
             | (  a & ~b &  c & ~d)  // 1 0 1 0 -> 1
             | (  a & ~b &  c &  d)  // 1 0 1 1 -> 0
             | (  a &  b & ~c & ~d)  // 1 1 0 0 -> 1
             | (  a &  b & ~c &  d)  // 1 1 0 1 -> 0
             | (  a &  b &  c & ~d)  // 1 1 1 0 -> 0
             | (  a &  b &  c &  d); // 1 1 1 1 -> 1

endmodule
