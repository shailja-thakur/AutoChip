module top_module(
    input x,
    input y,
    output z
);

    wire a;
    wire b;

    assign a = x & y;  // AND gate to calculate a
    assign b = ~x | ~y;  // NOR gate to calculate b
    assign z = a ^ b;  // XOR gate to calculate z

endmodule
