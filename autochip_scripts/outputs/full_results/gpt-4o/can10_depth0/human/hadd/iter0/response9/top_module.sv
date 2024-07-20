module top_module (
    input a,
    input b,
    output sum,
    output cout
);
    // Assigning sum and cout based on the logic of half adder
    assign sum = a ^ b;    // XOR gate for sum
    assign cout = a & b;   // AND gate for carry-out

endmodule
