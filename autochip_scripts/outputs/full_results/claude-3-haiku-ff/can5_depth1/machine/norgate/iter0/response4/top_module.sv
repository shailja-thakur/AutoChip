module top_module(
    input a,
    input b,
    output out
);

    // Implement the logic for the top_module
    assign out = ~(a | b);

endmodule
