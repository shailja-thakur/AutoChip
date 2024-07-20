module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    assign out = (~a & ~b & ~c & ~d) | (~a & ~b & ~c & d) | (~a & ~b & d & ~c) | (~a & d & ~b & c) |
                 (~a & d & b & a) | (~b & a & c & ~d) | (b & ~a & c & d) | (a & b & c & d) |
                 (a & ~b & ~c & ~d) | (a & ~b & d) | (~a & b & c & d) | (a & b & ~c & ~d);
endmodule
