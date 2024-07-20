module top_module(
    input a,
    input b,
    output out
);

    // Implement the logic for the top module
    assign out = ~(a | b);

endmodule
