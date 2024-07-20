module top_module (
    input a,
    input b,
    output sum,
    output cout
);

    assign sum = a ^ b;     // XOR gate generates the sum
    assign cout = a & b;    // AND gate generates the carry-out

endmodule
