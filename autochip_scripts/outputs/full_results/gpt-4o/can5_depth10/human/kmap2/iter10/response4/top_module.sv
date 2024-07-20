module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    assign out = (~a & ~b & ~c & ~d) | // 00 00 -> 1
                 (~a & ~b & ~c & d)  | // 00 01 -> 1
                 (~a & ~b & d & ~c)  | // 00 10 -> 1
                 (~a & ~b & d & c)   | // 00 11 -> 0
                 (~a & b & ~c & ~d)  | // 01 00 -> 1
                 (~a & b & ~c & d)   | // 01 01 -> 0
                 (~a & b & c & ~d)   | // 01 10 -> 0
                 (~a & b & c & d)    | // 01 11 -> 1
                 (a & ~b & ~c & ~d)  | // 10 00 -> 1
                 (a & ~b & ~c & d)   | // 10 01 -> 1
                 (a & ~b & c & ~d)   | // 10 10 -> 0
                 (a & ~b & c & d)    | // 10 11 -> 0
                 (a & b & ~c & ~d)   | // 11 00 -> 0
                 (a & b & ~c & d)    | // 11 01 -> 1
                 (a & b & c & ~d)    | // 11 10 -> 1
                 (a & b & c & d);      // 11 11 -> 1

endmodule
