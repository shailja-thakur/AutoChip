module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);
    assign out = (~a & ~b & ~c) | (~a & b & ~c) | (~a & b & d) | 
                 (a & b & ~c) | (a & ~b & ~d) | (a & c & d) | 
                 (~c & d & ~a) | (c & b & d);
endmodule
