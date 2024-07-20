module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    assign out = (~c & ~d) | // 00
                 (~c & b) | // 01
                 (d & ~b) | // 10
                 (b & ~a & c) | // 11, simplified to ~(a & ~b) & b & ~c
                 (~a & b & d) | // 10
                 (a & a & b) | // 11, simplified to a & b
                 (~a & b & d);  // 11

endmodule
