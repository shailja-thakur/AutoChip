module top_module(
    input a,
    input b,
    input c,
    output out
);

    // The Karnaugh map provided corresponds to the simplified Boolean expression: out = b + c + a
    assign out = b | c | a;

endmodule
