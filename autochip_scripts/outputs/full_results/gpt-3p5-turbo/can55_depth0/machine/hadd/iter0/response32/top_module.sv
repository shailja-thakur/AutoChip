module top_module (
    input a,
    input b,
    output sum,
    output cout
);

    // Declare internal wire for carry out
    wire carry_out;

    // Assign sum output
    assign sum = a + b;

    // Generate cout output
    assign cout = carry_out;

    // Generate carry out
    assign carry_out = (a & b);

endmodule
