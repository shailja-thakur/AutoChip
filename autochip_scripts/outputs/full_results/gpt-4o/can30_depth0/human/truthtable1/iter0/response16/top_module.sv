module top_module (
    input x3,
    input x2,
    input x1,
    output f
);

    // Using assign statement to implement the truth table
    assign f = (~x3 & x2) | (x3 & x1) | (x2 & x1);

endmodule
