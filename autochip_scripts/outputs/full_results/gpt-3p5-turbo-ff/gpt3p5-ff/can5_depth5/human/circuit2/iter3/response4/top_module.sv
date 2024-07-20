module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

  assign q = ((~a & ~b & ~c & d) | (~d & c & ~b & ~a) | (c & ~b & ~d) | (b & ~a) | (a & b & ~c & ~d));
  
endmodule
