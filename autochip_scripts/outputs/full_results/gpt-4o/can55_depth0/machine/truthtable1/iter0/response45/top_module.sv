module top_module (
    input x3,
    input x2,
    input x1,
    output f
);

    // Intermediate terms for the OR logic
    wire term1 = ~x3 & x2 & ~x1;
    wire term2 = ~x3 & x2 & x1;
    wire term3 = x3 & ~x2 & x1;
    wire term4 = x3 & x2 & x1;

    // OR operation combining all terms
    assign f = term1 | term2 | term3 | term4;

endmodule
