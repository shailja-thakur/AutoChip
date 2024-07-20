module top_module(
    input a,
    input b,
    input c,
    output out
);

assign out = (~a & ~b & ~c) | (~a & b) | (a & b & c) | (a & b & ~c) | (a & ~b & c) | (a & ~b & ~c);

endmodule
