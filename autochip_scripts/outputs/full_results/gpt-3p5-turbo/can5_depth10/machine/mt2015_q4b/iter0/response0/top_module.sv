module top_module(
    input x,
    input y,
    output z);

    // Logic gate implementation
    xor #(1) xor_gate(x, y, z);

endmodule
