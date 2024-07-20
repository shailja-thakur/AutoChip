module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    assign out = (~c & ~d) | (~a & ~b & d) | (~c & d & (a | b)) | (c & d & (~a | b)) | (a & c & b);

endmodule
