module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

assign q = (b & ~c) | (~b & c) | (~a & b & ~d) | (a & (~b | d));

endmodule
