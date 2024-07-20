module top_module(
    input x,
    input y,
    output z
);

    wire a;
    wire b;

    and gate1(a, x, ~y);  // AND gate to calculate a
    nand gate2(b, ~x, ~y);  // NAND gate to calculate b
    xor gate3(z, a, b);  // XOR gate to calculate z

endmodule
