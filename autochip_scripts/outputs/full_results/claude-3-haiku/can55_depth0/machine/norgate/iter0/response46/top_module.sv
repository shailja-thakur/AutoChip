module top_module(
    input a,
    input b,
    output out
);

    // Implement the logic
    assign out = ~(a | b);

endmodule
