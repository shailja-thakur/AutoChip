module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    assign out = (~c & ~d) | // 00XX
                 (~a & ~b & ~c) | // 000X
                 (~a & d) | // 01X1, 10X0
                 (a & b & (c | d)) | // 11XX
                 (a & ~b & d);  // 10X1

endmodule
