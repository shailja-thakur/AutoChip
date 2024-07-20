module top_module (
    input a,
    input b,
    output sum,
    output cout
);

assign sum = a ^ b;  // Sum is the result of the XOR of a and b
assign cout = a & b; // Carry-out is the result of the AND of a and b

endmodule
