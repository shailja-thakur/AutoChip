module top_module(
    input a,
    input b,
    output out
);

    // The output of the OR gate is the negation of the desired output
    wire or_output;

    // Implement the OR gate
    assign or_output = a | b;

    // Invert the output of the OR gate to get the desired output
    assign out = ~or_output;

endmodule
