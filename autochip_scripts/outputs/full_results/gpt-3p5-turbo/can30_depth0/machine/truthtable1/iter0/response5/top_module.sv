module top_module (
    input x3,
    input x2,
    input x1,
    output f
);

    // Internal signals
    wire condition1, condition2, condition3, condition4;

    // Gate-level representation of the conditions
    assign condition1 = ~x3 & x2 & ~x1;
    assign condition2 = ~x3 & x2 & x1;
    assign condition3 = x3 & ~x2 & x1;
    assign condition4 = x3 & x2 & x1;

    // Output assignment
    assign f = condition1 | condition2 | condition3 | condition4;

endmodule
