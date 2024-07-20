module top_module (
    input a,
    input b,
    output sum,
    output cout
);

assign {cout, sum} = a + b; // {cout, sum} concatenates the carry out and the sum

endmodule
