module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // Updated gates according to the specification
    or gate1(out1, x, y);  // 'or' gate for first gate
    and gate2(out2, x, y); // 'and' gate for second gate
    and gate3(z, out1, out2); // 'and' gate for third gate which takes the outputs of the first two gates

endmodule
