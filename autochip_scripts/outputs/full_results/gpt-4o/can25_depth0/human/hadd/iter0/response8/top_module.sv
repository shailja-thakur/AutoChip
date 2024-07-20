module top_module (
    input a,
    input b,
    output sum,
    output cout
);

assign sum = a ^ b;  // XOR gate for the sum
assign cout = a & b; // AND gate for the carry-out

endmodule
