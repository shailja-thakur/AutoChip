module top_module(
    input a, 
    input b,
    input c,
    output out
);

assign out = (b & ~a) | a;

endmodule
