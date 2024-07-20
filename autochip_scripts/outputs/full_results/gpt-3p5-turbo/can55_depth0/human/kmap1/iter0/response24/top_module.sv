module top_module(
    input a,
    input b,
    input c,
    output out
);

    // According to the Karnaugh map, there is only one case in which out should be 0, which is when abc = 00.
    // In all other cases, out should be 1.

    assign out = ~(a & b & c);

endmodule
