module top_module(
    input x3,
    input x2,
    input x1,
    output f
);

    // Corrected the boolean expression based on the truth table
    assign f = (x3 & ~x2 & x1) | (x3 & x2 & ~x1) | (~x3 & x2 & x1) | (x3 & x2 & x1);

endmodule
