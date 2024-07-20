module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);
    assign out = (~c & ~d) | (~c & b) | (a & ~b & d) | (a & b) | (c & d & ~a);
endmodule
