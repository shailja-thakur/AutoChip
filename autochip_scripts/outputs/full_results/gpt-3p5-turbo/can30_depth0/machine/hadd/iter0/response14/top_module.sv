module top_module (
    input a,
    input b,
    output sum,
    output cout
);

    // Declare internal wire for carry out
    wire co;

    // Assign sum and carry out
    assign {co, sum} = a + b;

    // Assign cout to carry out
    assign cout = co;

endmodule
