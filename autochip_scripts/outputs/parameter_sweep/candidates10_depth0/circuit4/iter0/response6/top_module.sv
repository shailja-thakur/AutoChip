module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

    assign q = (~a & b & c) | (~b & ~c & d) | (a & ~c & d) | (a & b & ~d);

endmodule
