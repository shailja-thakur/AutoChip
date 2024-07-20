module top_module(
    input a,
    input b,
    input c,
    output out
);

    // The Karnaugh map results in the simplified function: out = a | b
    assign out = a | b;

endmodule
