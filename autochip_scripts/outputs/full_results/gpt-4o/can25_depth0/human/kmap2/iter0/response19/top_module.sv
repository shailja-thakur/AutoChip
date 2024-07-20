module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    assign out = (~c & ~d & ~a) | (~c & ~d & ~b) | (~c & d & ~a) | 
                 (~c & d & ~b) | (~c & d & a) | (c & ~d & b) | 
                 (c & d & ~a) | (c & d & b);

endmodule
