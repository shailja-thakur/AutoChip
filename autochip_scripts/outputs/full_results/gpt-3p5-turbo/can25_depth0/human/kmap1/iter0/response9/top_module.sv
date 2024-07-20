module top_module(
    input a,
    input b,
    input c,
    output out
);

    // Wire declaration
    wire w1, w2, w3, w4;

    // Gate-level logic implementation
    and gate1(w1, a, c);
    or gate2(w2, a, b, c);
    and gate3(w3, b, c);
    or gate4(w4, w1, w2, w3);
    assign out = w4;

endmodule
