module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    assign out = (~c & ~d) | (~c & ~b) | (~d & ~b) | (c & d & ~a) | (c & ~d & ~b) | (d & ~a & ~b);

endmodule
