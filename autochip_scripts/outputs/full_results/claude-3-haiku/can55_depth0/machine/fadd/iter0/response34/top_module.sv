module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    // Assign the outputs based on the input values
    assign {cout, sum} = a + b + cin;

endmodule
