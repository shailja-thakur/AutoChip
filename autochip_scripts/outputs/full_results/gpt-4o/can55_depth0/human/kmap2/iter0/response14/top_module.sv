module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);
    assign out = (~a & ~b & ~c & ~d) | (~a & ~b & ~d) | (~a & ~d & c) | (~a & ~b & c) | (~a & b & d) | (~a & b & ~c & d) | (a & b & c & d) | (a & ~b & d) | (a & b & ~c & d) | (a & b & c);
endmodule
