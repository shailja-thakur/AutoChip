module top_module (
    input a,
    input b,
    output sum,
    output cout
);

    // Declare internal wire for carry calculation
    wire cout_intermediate;

    // Assign statements for sum and carry calculation
    assign sum = a + b;
    assign cout_intermediate = (a & b) | (a & cout) | (b & cout);
    assign cout = cout_intermediate;

endmodule
