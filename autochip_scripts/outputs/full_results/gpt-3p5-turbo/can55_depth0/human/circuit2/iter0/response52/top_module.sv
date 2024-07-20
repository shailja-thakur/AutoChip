module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

    // assign output signal q based on input signals a, b, c, and d
    assign q = ~a & ~b & ~c & d | ~a & ~b & c & ~d | ~a & b & ~c & ~d
        | ~a & b & c & d | a & ~b & ~c & ~d | a & ~b & c & ~d
        | a & b & ~c & d | a & b & c & ~d;

endmodule
