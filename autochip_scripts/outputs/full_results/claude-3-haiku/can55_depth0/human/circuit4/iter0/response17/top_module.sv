module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

    assign q = (b & ~c & ~d) | (b & c & ~d) | (~a & b & d) | (a & ~b & c) | (a & b);

endmodule
