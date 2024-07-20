module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);
    assign out = (~c & ~d & ~b) | (~c & a & ~d) | (~c & b & ~a & ~d) | (~c & d & ~a & ~b) | (~c & b & d) | (c & ~a & d) | (c & b & ~d) | (c & b & a);

endmodule
