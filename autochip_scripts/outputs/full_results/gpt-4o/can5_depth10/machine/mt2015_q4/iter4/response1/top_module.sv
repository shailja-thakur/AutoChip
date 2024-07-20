module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    and gate1(out1, x, y);   // First gate: AND gate
    and gate2(out2, y, x);   // Changed OR gate to AND gate as per original logic
    or  gate3(z, out1, out2); // Changed AND gate to OR gate as per original logic

endmodule
