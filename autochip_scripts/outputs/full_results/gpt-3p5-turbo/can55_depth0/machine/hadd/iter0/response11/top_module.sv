module top_module (
    input a,
    input b,
    output sum,
    output cout
);

    // Declare internal signals
    wire carry;

    // Assign the sum and carry out
    assign {carry, sum} = a + b;

    // Assign the carry out
    assign cout = carry;

endmodule
