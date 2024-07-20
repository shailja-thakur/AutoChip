module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);
    assign q = (~a & ~b & ~c & ~d) | 
               (c & ~d & ~b & ~a) | 
               (d & ~c & ~b & ~a) | 
               (b & ~c & c & d) | 
               (~a & b & c & ~c) | 
               (~a & b & ~c & d & d) |
               (a & ~b & c & ~d);
endmodule
