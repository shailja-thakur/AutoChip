module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // Updated gates according to the corrected logic
    and gate1(out1, x, y); // Updated to 'and' gate
    or gate2(out2, y, x);  // Updated to 'or' gate
    or gate3(z, out1, out2); // Updated to 'or' gate which takes the outputs of the first two gates

endmodule
