module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // According to typical logic gate behavior, let's recheck and correct gates to match the descriptions precisely
    and gate1(out1, x, y);  // 'and' gate for the first gate
    or gate2(out2, y, x);   // 'or' gate for the second gate
    xor gate3(z, out1, out2); // 'xor' gate for the third gate

endmodule
