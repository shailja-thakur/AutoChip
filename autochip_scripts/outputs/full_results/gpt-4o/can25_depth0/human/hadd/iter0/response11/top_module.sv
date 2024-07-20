module top_module (
    input a,
    input b,
    output sum,
    output cout
);
    assign sum = a ^ b;  // Sum is the result of a XOR b
    assign cout = a & b; // Carry out is the result of a AND b
endmodule
