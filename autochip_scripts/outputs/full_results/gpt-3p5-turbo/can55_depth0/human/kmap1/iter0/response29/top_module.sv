module top_module(
    input a,
    input b,
    input c,
    output out
);
    // Intermediate signals
    wire w1;

    // Logic gates
    assign w1 = ~(a & ~b & c);
    assign out = ~(~w1 & b & c);

endmodule
