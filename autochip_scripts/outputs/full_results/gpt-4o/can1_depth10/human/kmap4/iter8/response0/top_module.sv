module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

assign out = (~c & ~d & b) | (~c & d & ~b) |
             (c & ~d & ~b) | (c & d & b);

endmodule
