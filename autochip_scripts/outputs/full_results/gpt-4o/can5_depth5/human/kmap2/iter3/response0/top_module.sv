module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    assign out = (~c & ~d) | (~a & ~b & d) | (a & b & ~c) | (a & c & d) | (b & ~c & d);

endmodule
