module top_module(
    input x,
    input y,
    output z);

    wire gate1_out;
    wire gate2_out;

    // First gate (AND gate as an example)
    and gate1 (gate1_out, x, y);

    // Second gate (OR gate as an example)
    or gate2 (gate2_out, y, x);

    // Third gate (XOR gate as an example)
    xor gate3 (z, gate1_out, gate2_out);

endmodule
