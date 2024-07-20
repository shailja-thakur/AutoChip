module top_module(
    input x,
    input y,
    output z);

    wire gate1_out;
    wire gate2_out;

    // First gate: AND gate
    and and1(gate1_out, x, y);

    // Second gate: OR gate
    or or1(gate2_out, y, x);

    // Third gate: XOR gate
    xor xor1(z, gate1_out, gate2_out);

endmodule
