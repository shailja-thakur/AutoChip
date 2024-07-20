module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);
    assign out = (~c & ~d) | (a & ~d & ~b) | (c & ~b & a) | (~a & ~c & d) | (b & c & d);
endmodule
