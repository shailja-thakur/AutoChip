module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    assign out = (~c & ~d) | (~c & a) | (c & b) | (c & d & ~a) | (~a & d & ~b);

endmodule
