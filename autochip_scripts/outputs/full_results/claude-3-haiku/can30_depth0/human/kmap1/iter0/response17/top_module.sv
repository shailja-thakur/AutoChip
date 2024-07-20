module top_module(
    input a,
    input b, 
    input c,
    output out
);

assign out = (c | ~a) & (b | ~a);

endmodule
