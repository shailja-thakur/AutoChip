module top_module(
    input x,
    input y,
    output z
    );

    // Intermediate signal to hold the result of (x^y)
    wire temp;

    // XOR gate to compute (x^y)
    xor gate1(temp, x, y);

    // AND gate to compute (x^y) & x
    and gate2(z, temp, x);

endmodule
