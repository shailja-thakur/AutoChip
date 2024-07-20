module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

    // Implementing the truth table
    assign q = ((~a & ~b & ~c & ~d) | (d & (~a | ~b | ~c)) | (~d & (a | b | c)));

endmodule
