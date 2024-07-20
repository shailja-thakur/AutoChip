module top_module (
    input a,
    input b,
    output sum,
    output cout
);

assign sum = a ^ b;   // XOR operation gives the sum
assign cout = a & b;  // AND operation gives the carry out

endmodule
