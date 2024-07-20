module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

assign q = (c & d) | (~a & ~b);

endmodule
