module top_module (
    input a,
    input b,
    output sum,
    output cout
);
    // Sum is the XOR of a and b
    assign sum = a ^ b;
    // Carry-out is the AND of a and b
    assign cout = a & b;
endmodule
