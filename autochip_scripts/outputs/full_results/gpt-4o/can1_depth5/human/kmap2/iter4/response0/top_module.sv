module top_module (
    input a,
    input b,
    input c,
    input d,
    output out
);

    // Deriving the correct boolean expression from the Karnaugh map:
    // out = (~a & ~c & ~d) | (~a & d) | (~b & ~d) | (~b & c) | (a & b & c)
    // Simplifying this expression:
    // out = (d & (~a | ~b)) | (~a & ~b) | (~b & c)
    // Further simplification gives:
    // out = (~a & ~b) | (d & ~a) | (d & ~b) | (c & ~b)
    // Further re-ordering terms gives:
    // out = (~a & ~b) | (d & (~a | ~b)) | (~b & c)

    assign out = (~a & ~b) | (d & (~a | ~b)) | (~b & c);

endmodule
