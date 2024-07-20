module top_module(
    input a,
    input b,
    input c,
    output out
);

    wire d;

    assign d = ~(~b & c);

    assign out = (~a & ~b & ~c) | (~a & b & ~c) | (a & b & ~c) | (~a & b & c) | (a & b & c);

endmodule
