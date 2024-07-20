module top_module (
    input a,
    input b,
    output sum,
    output cout
);

    // Half adder logic
    assign sum = a ^ b;
    assign cout = a & b;

endmodule
