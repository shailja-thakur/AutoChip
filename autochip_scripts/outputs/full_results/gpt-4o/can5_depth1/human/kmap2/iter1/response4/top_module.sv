module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    assign out = (~c & ~d) | (~c & ~b & d) | (~a & ~b & d) | (~a & c & d) | (a & ~b & c) | (a & b & ~d);

endmodule
