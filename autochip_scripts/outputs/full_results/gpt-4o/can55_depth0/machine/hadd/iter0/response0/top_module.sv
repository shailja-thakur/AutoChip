module top_module (
    input a,
    input b,
    output sum,
    output cout
);
    // Assign statements to calculate sum and cout
    assign {cout, sum} = a + b;
endmodule
