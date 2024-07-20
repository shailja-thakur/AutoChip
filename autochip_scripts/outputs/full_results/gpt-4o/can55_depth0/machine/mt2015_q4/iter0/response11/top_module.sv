module top_module(
    input x,
    input y,
    output z
);

    wire a1, a2, a3;

    // First logic gate (let's use AND gate for example)
    and gate1(a1, x, y);

    // Second logic gate (let's use OR gate for example)
    or gate2(a2, y, x);

    // Third logic gate (let's use XOR gate for example)
    xor gate3(z, a1, a2);

endmodule
