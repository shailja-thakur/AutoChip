module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // First logic gate
    and gate1(out1, x, y); // AND gate example: you may choose other types like OR, XOR, etc.
    
    // Second logic gate
    or gate2(out2, y, x);  // OR gate example: you may choose other types like AND, XOR, etc.
    
    // Third logic gate
    xor gate3(z, out1, out2); // XOR gate example: you may choose other types like AND, OR, etc.

endmodule
