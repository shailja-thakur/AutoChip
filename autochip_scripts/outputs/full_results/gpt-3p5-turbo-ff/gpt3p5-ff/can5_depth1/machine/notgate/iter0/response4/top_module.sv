module top_module(
    input in,
    output out
);

    // Assign the output to the inversion of the input
    assign out = ~in;

endmodule
