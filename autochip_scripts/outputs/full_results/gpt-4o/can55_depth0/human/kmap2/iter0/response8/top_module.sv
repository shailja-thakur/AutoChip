module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);
    assign out = (~c & ~d) | (~c & ~b) | (c & d & ~b) | (c & d & a) | (a & ~b & ~d) | (~a & b & ~c & d);
endmodule
