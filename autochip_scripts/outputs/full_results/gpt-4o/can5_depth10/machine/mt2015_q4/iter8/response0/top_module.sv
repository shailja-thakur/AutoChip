module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // Adjust gate types according to the problem specification
    and gate1(out1, x, y); // Changed back to AND gate based on logical consistency
    or gate2(out2, y, x);  // Changed back to OR gate based on logical consistency
    and gate3(z, out1, out2); // Changed the gate to AND gate which takes outputs of the first two gates

endmodule
