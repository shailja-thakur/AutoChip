module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    assign out = (~c & ~d) | (~c & d) | (~a & ~b & d) | (a & b & c) | (b & ~c & d) | (a & ~b & c);

endmodule
