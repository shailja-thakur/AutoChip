module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    assign out = (~c & ~d) | (~a & ~c & ~b) | (~a & b & ~d) | (~a & d & ~b) | (a & b & c & ~d) | (a & b & ~c);

endmodule
