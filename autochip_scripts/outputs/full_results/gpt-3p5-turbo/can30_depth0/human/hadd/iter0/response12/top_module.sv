module top_module (
    input a,
    input b,
    output sum,
    output cout
);

    assign sum = a ^ b;    // XOR gate produces the sum
    assign cout = a & b;   // AND gate produces the carry-out

endmodule
