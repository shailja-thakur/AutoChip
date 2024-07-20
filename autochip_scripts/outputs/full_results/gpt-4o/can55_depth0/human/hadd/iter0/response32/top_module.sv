module top_module (
    input a,
    input b,
    output sum,
    output cout
);
    assign sum = a ^ b;  // Sum is calculated using XOR gate
    assign cout = a & b; // Carry-out is calculated using AND gate
endmodule
