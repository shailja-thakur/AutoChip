module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    assign out = (~c & ~d & ~a) |       // 0000, 1000
                 (~c & ~d & b) |        // 0100
                 (~c & d & ~a) |        // 0010, 0111
                 (~c & d & b) |         // 1011
                 (c & ~d & b) |         // 1100
                 (c & d & ~b) |         // 1010
                 (c & d & a & b) |      // 1110, 1111
                 (~a & b & ~d);         // 1010
  
endmodule
