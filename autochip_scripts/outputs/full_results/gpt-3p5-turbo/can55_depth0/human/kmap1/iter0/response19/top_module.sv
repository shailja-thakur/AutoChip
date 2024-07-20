module top_module(
    input a, 
    input b,
    input c,
    output out
);

    // Intermediate signals
    wire w1, w2;

    // Implement the logic equations
    assign w1 = (~b & c) | (a & b & c);
    assign w2 = (~a & b & c) | (a & b & ~c);
    assign out = w1 | w2;

endmodule
