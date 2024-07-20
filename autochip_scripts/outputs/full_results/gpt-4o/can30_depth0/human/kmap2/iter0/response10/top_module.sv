module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    assign out = (~c & ~d) | (~a & ~b & ~d) | (a & ~c) | (c & d & b) | (a & d & b);

endmodule
