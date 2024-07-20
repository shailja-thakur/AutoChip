module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // First gate
    // Assuming it's an AND gate, you can change it to other types of gates (OR, XOR, etc.)
    and gate1 (out1, x, y);

    // Second gate
    // Assuming it's an OR gate, you can change it to other types of gates (AND, XOR, etc.)
    or gate2 (out2, y, x);

    // Third gate
    // Assuming it's a NAND gate, you can change it to other types of gates (AND, OR, etc.)
    nand gate3 (z, out1, out2);

endmodule
