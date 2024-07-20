module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    assign out = (~c & d & ~b) | (~c & ~b & ~d) | (~c & b & a) | (c & d & ~a) | (c & ~d & b & ~a) | (~c & b & ~d) | (~c & b & d);

endmodule
