module top_module(
    input a, 
    input b,
    input c,
    output out
);

    assign out = (~b & a) | (b & c) | (b & ~c & a);

endmodule
