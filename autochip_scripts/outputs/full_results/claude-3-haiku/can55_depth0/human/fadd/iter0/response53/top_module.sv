module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire s1, c1, c2;

    // Half adder for the two inputs
    assign {c1, sum} = a + b;

    // Add the carry-in to the half adder result
    assign {cout, s1} = {c1, sum} + cin;

endmodule
