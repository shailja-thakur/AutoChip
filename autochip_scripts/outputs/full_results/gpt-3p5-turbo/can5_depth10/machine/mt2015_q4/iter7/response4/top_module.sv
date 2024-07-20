module top_module(
    input x,
    input y,
    output z
);

    wire a;
    wire b;

    assign a = x ^ y;  // Use XOR gate instead of AND gate
    assign b = y ^ x;  // Use XOR gate instead of OR gate
    assign z = a | b;  // Use OR gate instead of XOR gate

endmodule
