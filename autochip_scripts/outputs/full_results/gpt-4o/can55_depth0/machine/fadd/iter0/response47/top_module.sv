module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);
    // Calculate the sum of a, b, and cin
    assign {cout, sum} = a + b + cin;

endmodule
