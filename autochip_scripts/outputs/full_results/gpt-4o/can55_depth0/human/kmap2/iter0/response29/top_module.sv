module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    assign out = 
        (~a & ~b & ~c & ~d) | // 0000 -> 1
        (~a & ~b & ~c &  d) | // 0001 -> 1
        (~a & ~b &  b & ~d) | // 0010 -> 1
        (~a & ~b &  b &  d) | // 0011 -> 0
        (~a &  b & ~c & ~d) | // 0100 -> 1
        (~a &  b & ~c &  d) | // 0101 -> 0
        (~a &  b &  c & ~d) | // 0110 -> 0
        (~a &  b &  c &  d) | // 0111 -> 1
         (a & ~b & ~c & ~d) | // 1000 -> 1
         (a & ~b & ~c &  d) | // 1001 -> 1
         (a & ~b &  b & ~d) | // 1010 -> 0
         (a & ~b &  b &  d) | // 1011 -> 0
         (a &  b & ~c & ~d) | // 1100 -> 0
         (a &  b & ~c &  d) | // 1101 -> 1
         (a &  b &  b & ~d) | // 1110 -> 1
         (a &  b &  b &  d);  // 1111 -> 1

endmodule
