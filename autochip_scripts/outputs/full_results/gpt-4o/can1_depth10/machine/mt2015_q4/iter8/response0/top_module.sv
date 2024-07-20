module top_module(
    input x,
    input y,
    output z);

    wire w1, w2;

    // First gate (OR gate, instead of AND as initially)
    assign w1 = x | y;

    // Second gate (NAND gate, instead of NOR as initially)
    assign w2 = ~(x & y);

    // Third gate (AND gate remains as is)
    assign z = w1 & w2;

endmodule
