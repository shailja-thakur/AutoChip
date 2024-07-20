module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // Updated gates according to the specification
    and gate1(out1, x, y); // 'and' gate for first gate
    or gate2(out2, y, x);  // 'or' gate for second gate
    xor gate3(z, out1, out2); // 'xor' gate for third gate which takes the outputs of the first two gates

endmodule
