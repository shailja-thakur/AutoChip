module top_module (
    input a,
    input b,
    output sum,
    output cout
);

// Assign statement to calculate sum and cout
assign sum = a + b;
assign cout = a & b; // Carry out is the result of bitwise AND operation

endmodule
