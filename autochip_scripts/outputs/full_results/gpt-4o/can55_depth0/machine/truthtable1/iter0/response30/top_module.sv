module top_module (
    input x3,
    input x2,
    input x1,
    output f
);
    // Intermediate signals for the conditions
    wire condition1, condition2, condition3, condition4;

    // Define the conditions
    assign condition1 = ~x3 & x2 & ~x1;
    assign condition2 = ~x3 & x2 & x1;
    assign condition3 = x3 & ~x2 & x1;
    assign condition4 = x3 & x2 & x1;

    // Output f is high if any of the conditions are met
    assign f = condition1 | condition2 | condition3 | condition4;
endmodule
