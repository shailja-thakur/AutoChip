module top_module (
    input a,
    input b,
    output sum,
    output cout
);

    assign sum = a ^ b;    // Sum is XOR of a and b
    assign cout = a & b;   // Carry out is AND of a and b

endmodule
