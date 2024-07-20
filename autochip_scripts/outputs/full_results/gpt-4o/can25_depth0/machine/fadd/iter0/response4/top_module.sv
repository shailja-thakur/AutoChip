module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);
    // Intermediate sum
    wire temp_sum;

    // Compute sum of a and b
    assign temp_sum = a + b;

    // Compute final sum with carry-in
    assign sum = temp_sum + cin;

    // Compute carry-out
    assign cout = (a & b) | (cin & (a ^ b));

endmodule
