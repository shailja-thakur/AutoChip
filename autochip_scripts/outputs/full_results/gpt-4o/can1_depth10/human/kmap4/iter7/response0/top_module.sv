module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

assign out = (~c & ~d & a & ~b) | (~c & ~d & ~a & b) |
             (~c & d & a & ~b) | (~c & d & ~a & b) |
             (c & ~d & a & ~b) | (c & ~d & ~a & b) |
             (c & d & a & ~b) | (c & d & ~a & b);

endmodule
