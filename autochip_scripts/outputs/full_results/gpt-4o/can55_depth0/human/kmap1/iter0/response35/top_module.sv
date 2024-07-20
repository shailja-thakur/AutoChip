module top_module(
    input a, 
    input b,
    input c,
    output out
);

assign out = (~a & c) | (b & c) | (a & c) | (b & ~a) | (b & ~c);

endmodule
