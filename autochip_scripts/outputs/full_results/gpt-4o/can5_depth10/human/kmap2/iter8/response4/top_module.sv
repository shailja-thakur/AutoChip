module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    assign out = (~a & ~b & ~c) | // 00 00, 00 01, 01 00, 01 10
                 (~a & b & ~d) | // 00 10, 01 00
                 (~a & b & c) | // 01 10
                 (~a & ~c & d) | // 00 01
                 (a & ~b & ~c) | // 10 00
                 (a & ~b & d) | // 10 01
                 (a & b & c) | // 11 11, 11 10
                 (a & b & ~d) | // 11 00
                 (a & ~c & ~d); // 10 00
                 
endmodule
