module top_module(
    input a, 
    input b,
    input c,
    output out
);

    assign out = (~b & c) | (b & c) | (~a & ~b) | (a & b);

endmodule
