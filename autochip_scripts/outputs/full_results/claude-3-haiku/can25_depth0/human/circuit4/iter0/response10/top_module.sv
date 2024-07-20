module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

assign q = (c & d) | (~c & b) | (a & ~b & ~c) | (a & b & ~c & ~d);

endmodule
